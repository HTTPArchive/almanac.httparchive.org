#standardSQL
# 03_03a: % of pages with custom elements ("slang")
CREATE TEMPORARY FUNCTION containsCustomElement(payload STRING)
RETURNS BOOLEAN LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var elements = JSON.parse($._element_count)
  return Object.keys(elements).filter(e => e.includes('-')).length > 0;
} catch (e) {
  return false;
}
''';

SELECT
  _TABLE_SUFFIX AS client,
  COUNTIF(containsCustomElement(payload)) AS pages,
  ROUND(COUNTIF(containsCustomElement(payload)) * 100 / COUNT(0), 2) AS pct_pages
FROM
  `httparchive.pages.2019_07_01_*`
GROUP BY
  client
