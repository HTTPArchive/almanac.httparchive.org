#standardSQL
# metrics grouped by device
# See related: sql/2019/03_Markup/03_01a.sql, sql/2019/03_Markup/03_05.sql, sql/2019/03_Markup/03_03a.sql
CREATE TEMPORARY FUNCTION containsDeprecatedElement(elementsJsonString STRING)
RETURNS BOOLEAN LANGUAGE js AS '''
try {
  var elements = JSON.parse(elementsJsonString)
  var deprecatedElements = new Set(["applet","acronym","bgsound","dir","frame","frameset","noframes","isindex","keygen","listing","menuitem","nextid","noembed","plaintext","rb","rtc","strike","xmp","basefont","big","blink","center","font","marquee","multicol","nobr","spacer","tt"]);
  return !!Object.keys(elements).find(e => {
    return deprecatedElements.has(e);
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

SELECT
  client,
  COUNT(0) AS total,

  # % of pages with deprecated elements
  COUNTIF(contains_deprecated_element) AS contains_deprecated_element,
  ROUND(COUNTIF(contains_deprecated_element) * 100 / COUNT(0), 2) AS pct_contains_deprecated_element,

  # % of pages with custom elements ("slang")
  COUNTIF(contains_custom_element) AS contains_custom_element,
  ROUND(COUNTIF(contains_custom_element) * 100 / COUNT(0), 2) AS pct_contains_custom_element,

  # % of pages with shadow roots
  COUNTIF(has_shadow_root) AS has_shadow_root,
  ROUND(COUNTIF(has_shadow_root) * 100 / COUNT(0), 2) AS pct_has_shadow_root

FROM (
  SELECT
    client,
    containsDeprecatedElement(elements) AS contains_deprecated_element, 
    containsCustomElement(elements) AS contains_custom_element, 
    CAST(JSON_EXTRACT_SCALAR(payload, '$._has_shadow_root') AS BOOLEAN) AS has_shadow_root
  FROM
    ( 
      SELECT 
      _TABLE_SUFFIX AS client,
      payload,
      #JSON_EXTRACT_SCALAR(payload, '$._almanac') AS almanac
      JSON_EXTRACT_SCALAR(payload, '$._element_count') AS elements 
      FROM
      `httparchive.almanac.pages_*`
    )
)
GROUP BY
  client