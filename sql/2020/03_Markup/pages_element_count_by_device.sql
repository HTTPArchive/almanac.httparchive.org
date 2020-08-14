#standardSQL
# page element_count metrics grouped by device

# to speed things up there is only one js function per custom metric property. It returns a STRUCT with all the data needed
# current test gathers 3 bits of incormation from teo custom petric properties
# I tried to do a single js function processing payload but it was very slow (50 sec) because of parsing the full payload in js
# this uses JSON_EXTRACT_SCALAR to first get the custom metrics json string, and only passes those into the js functions
# Estimate about twice the speed of the original code. But should scale up far better as the custom metrics are only parsed once.
# real test ($2.90) 39.1 sec

# helper to create percent fields
CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

# returns all the data we need from _element_count
CREATE TEMPORARY FUNCTION get_element_count_info(element_count_string STRING)
RETURNS STRUCT<
  count INT64,
  contains_custom_element BOOL, 
  contains_obsolete_element BOOL,
  contains_details_element BOOL,
  contains_summary_element BOOL
> LANGUAGE js AS '''
var result = {};
try {
    if (!element_count_string) return result;

    var element_count = JSON.parse(element_count_string);

    if (Array.isArray(element_count) || typeof element_count != 'object') return result;

    result.count = Object.values(element_count).reduce((total, freq) => total + (parseInt(freq, 10) || 0), 0);
    
    result.contains_custom_element = Object.keys(element_count).filter(e => e.includes('-')).length > 0;
    result.contains_details_element = Object.keys(element_count).filter(e => e ==='details').length > 0;
    result.contains_summary_element = Object.keys(element_count).filter(e => e ==='summary').length > 0;

    var obsoleteElements = new Set(["applet","acronym","bgsound","dir","frame","frameset","noframes","isindex","keygen","listing","menuitem","nextid","noembed","plaintext","rb","rtc","strike","xmp","basefont","big","blink","center","font","marquee","multicol","nobr","spacer","tt"]);

    result.contains_obsolete_element = !!Object.keys(element_count).find(e => {
        return obsoleteElements.has(e);
    });

} catch (e) {}
return result;
''';

SELECT
  client,
  COUNT(0) AS total,

  ## element_count

  CAST(ROUND(AVG(element_count_info.count)) AS INT64) AS elements_avg, # not sure what value this is? average elements per page? same for all device rows
  MIN(element_count_info.count) AS elements_min, # y-axis min, same for all device rows
  MAX(element_count_info.count) AS elements_max, # y-axis max, same for all device rows

  # % of pages with obsolete elements related to M216
  COUNTIF(element_count_info.contains_obsolete_element) AS freq_contains_obsolete_element,
  AS_PERCENT(COUNTIF(element_count_info.contains_obsolete_element), COUNT(0)) AS pct_contains_obsolete_element,

  # % of pages with custom elements ("slang") related to M242
  COUNTIF(element_count_info.contains_custom_element) AS freq_contains_custom_element,
  AS_PERCENT(COUNTIF(element_count_info.contains_custom_element), COUNT(0)) AS pct_contains_custom_element,

  # % of pages with details and summary elements M214
  COUNTIF(element_count_info.contains_details_element AND element_count_info.contains_summary_element) AS freq_contains_details_and_summary_element,
  AS_PERCENT(COUNTIF(element_count_info.contains_details_element AND element_count_info.contains_summary_element), COUNT(0)) AS pct_contains_details_and_summary_element_m214,

  FROM
    ( 
      SELECT 
        _TABLE_SUFFIX AS client,
        get_element_count_info(JSON_EXTRACT_SCALAR(payload, '$._element_count')) AS element_count_info # LIVE
      FROM
        `httparchive.sample_data.pages_*` # TEST
    )
GROUP BY
  client