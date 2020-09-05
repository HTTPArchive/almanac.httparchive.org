#standardSQL
# percientile data from element_count per device - NOT USED

# returns all the data we need from _element_count
CREATE TEMPORARY FUNCTION get_element_count_info(element_count_string STRING)
RETURNS STRUCT<
  count INT64#,
  #contains_custom_element BOOL, 
  #contains_obsolete_element BOOL,
  #contains_details_element BOOL,
  #contains_summary_element BOOL
> LANGUAGE js AS '''
var result = {};
try {
    if (!element_count_string) return result;

    var element_count = JSON.parse(element_count_string);

    if (Array.isArray(element_count) || typeof element_count != 'object') return result;

    result.count = Object.values(element_count).reduce((total, freq) => total + (parseInt(freq, 10) || 0), 0);
    
    //result.contains_custom_element = Object.keys(element_count).filter(e => e.includes('-')).length > 0;
    //result.contains_details_element = Object.keys(element_count).filter(e => e ==='details').length > 0;
    //result.contains_summary_element = Object.keys(element_count).filter(e => e ==='summary').length > 0;

    //var obsoleteElements = new Set(["applet","acronym","bgsound","dir","frame","frameset","noframes","isindex","keygen","listing","menuitem","nextid","noembed","plaintext","rb","rtc","strike","xmp","basefont","big","blink","center","font","marquee","multicol","nobr","spacer","tt"]);

    //result.contains_obsolete_element = !!Object.keys(element_count).find(e => {
    //    return obsoleteElements.has(e);
    //});

} catch (e) {}
return result;
''';

SELECT
  percentile,
  client,
  COUNT(DISTINCT url) AS total,

  # Elements per page
  APPROX_QUANTILES(element_count_info.count, 1000)[OFFSET(percentile * 10)] AS elements_count,

FROM (
  SELECT 
    _TABLE_SUFFIX AS client,
    percentile,
    url,
    get_element_count_info(JSON_EXTRACT_SCALAR(payload, '$._element_count')) AS element_count_info
  FROM
  `httparchive.sample_data.pages_*`, # TEST
  #`httparchive.pages.2020_08_01_*`, # LIVE
  UNNEST([10, 25, 50, 75, 90]) AS percentile
)
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
