#standardSQL
# pages element_count metrics grouped by device

# helper to create percent fields
CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

# returns all the data we need from _element_count
CREATE TEMPORARY FUNCTION get_element_count_info(element_count_string STRING)
RETURNS STRUCT<
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

  # % of pages with obsolete elements related to M216
  AS_PERCENT(COUNTIF(element_count_info.contains_obsolete_element), COUNT(0)) AS pct_contains_obsolete_element_m216,

  # % of pages with custom elements ("slang") related to M242
  AS_PERCENT(COUNTIF(element_count_info.contains_custom_element), COUNT(0)) AS pct_contains_custom_element_m242,

  # % of pages with details and summary elements M214
  AS_PERCENT(COUNTIF(element_count_info.contains_details_element AND element_count_info.contains_summary_element), COUNT(0)) AS pct_contains_details_and_summary_element_m214,

  FROM
    ( 
      SELECT 
        _TABLE_SUFFIX AS client,
        get_element_count_info(JSON_EXTRACT_SCALAR(payload, '$._element_count')) AS element_count_info
      FROM
        `httparchive.pages.2020_08_01_*` 
    )
GROUP BY
  client
  