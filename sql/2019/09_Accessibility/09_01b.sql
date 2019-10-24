#standardSQL
# 09_01b: % of pages having any heading
CREATE TEMPORARY FUNCTION hasHeading(payload STRING)
RETURNS BOOLEAN LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var elements = JSON.parse($._element_count);
  if (Array.isArray(elements) || typeof elements != 'object') {
    return false;
  }

  return (elements.h1 || elements.h2 || elements.h3 || elements.h4 || elements.h5 || elements.h6 || 0) > 0;
} catch (e) {
  return false;
}
''';

SELECT
  client,
  COUNT(0) AS total_pages,
  COUNTIF(has_heading) AS total_with_heading,
  ROUND(COUNTIF(has_heading) * 100 / COUNT(0), 2) AS pct_with_heading
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    hasHeading(payload) AS has_heading
  FROM
    `httparchive.pages.2019_07_01_*`
)
GROUP BY
  client
