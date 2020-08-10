#standardSQL
# metrics grouped by device
# See related: sql/2019/03_Markup/03_01a.sql, sql/2019/03_Markup/03_05.sql, sql/2019/03_Markup/03_03a.sql
CREATE TEMPORARY FUNCTION containsObsoleteElement(elementsJsonString STRING)
RETURNS BOOLEAN LANGUAGE js AS '''
try {
  var elements = JSON.parse(elementsJsonString)
  var obsoleteElements = new Set(["applet","acronym","bgsound","dir","frame","frameset","noframes","isindex","keygen","listing","menuitem","nextid","noembed","plaintext","rb","rtc","strike","xmp","basefont","big","blink","center","font","marquee","multicol","nobr","spacer","tt"]);
  return !!Object.keys(elements).find(e => {
    return obsoleteElements.has(e);
  });
} catch (e) {
  return false;
}
''';

CREATE TEMPORARY FUNCTION containsCustomElement(elementsJsonString STRING)
RETURNS BOOLEAN LANGUAGE js AS '''
try {
  var elements = JSON.parse(elementsJsonString)
  return Object.keys(elements).filter(e => e.includes('-')).length > 0;
} catch (e) {
  return false;
}
''';

CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

SELECT
  client,
  COUNT(0) AS total,

  # % of pages with obsolete elements
  COUNTIF(contains_obsolete_element) AS freq_contains_obsolete_element,
  AS_PERCENT(COUNTIF(contains_obsolete_element), COUNT(0)) AS pct_contains_obsolete_element,

  # % of pages with custom elements ("slang")
  COUNTIF(contains_custom_element) AS freq_contains_custom_element,
  AS_PERCENT(COUNTIF(contains_custom_element), COUNT(0)) AS pct_contains_custom_element,

  # % of pages with shadow roots
  COUNTIF(has_shadow_root) AS freq_has_shadow_root,
  AS_PERCENT(COUNTIF(has_shadow_root), COUNT(0)) AS pct_has_shadow_root,

  # % of pages with scripts M204 
  COUNTIF(has_scripts) AS freq_has_scripts,
  AS_PERCENT(COUNTIF(has_scripts), COUNT(0)) AS pct_has_scripts

FROM (
  SELECT
    client,
    containsObsoleteElement(element_count) AS contains_obsolete_element, 
    containsCustomElement(element_count) AS contains_custom_element, 
    CAST(JSON_EXTRACT_SCALAR(payload, '$._has_shadow_root') AS BOOLEAN) AS has_shadow_root,
    CAST(JSON_EXTRACT_SCALAR(almanac, '$.scripts.total') AS INT64) > 0 AS has_scripts # needs to filter out ld+json
  FROM
    ( 
      SELECT 
      _TABLE_SUFFIX AS client,
      payload,
    #  JSON_EXTRACT_SCALAR(payload, '$._markup') AS markup,     
      JSON_EXTRACT_SCALAR(payload, '$._almanac') AS almanac,     
     # JSON_EXTRACT_SCALAR(payload, '$._wpt_bodies') AS wpt_bodies,
     # JSON_EXTRACT_SCALAR(payload, '$._robots_txt') AS robots_txt,
      JSON_EXTRACT_SCALAR(payload, '$._element_count') AS element_count#,
      #getElementInfo(JSON_EXTRACT_SCALAR(payload, '$._almanac')) AS element_info
      FROM
      `httparchive.sample_data.pages_*`
    )
)
GROUP BY
  client