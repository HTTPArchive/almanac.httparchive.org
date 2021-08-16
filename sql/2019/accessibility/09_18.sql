#standardSQL
# 09_18: % of pages having a table caption/thead
# Caveat: This does not necessarily enforce that the element is within the table.
CREATE TEMPORARY FUNCTION getTableElements(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var elements = JSON.parse($._element_count);
  if (Array.isArray(elements) || typeof elements != 'object') return [];
  var tableElements = new Set(['table', 'caption', 'thead']);
  return Object.keys(elements).filter(e => tableElements.has(e));
} catch (e) {
  return [];
}
''';

SELECT
  client,
  COUNTIF('caption' IN UNNEST(table_elements)) AS caption_pages,
  COUNTIF('thead' IN UNNEST(table_elements)) AS thead_pages,
  COUNT(0) AS table_pages,
  ROUND(COUNTIF('caption' IN UNNEST(table_elements)) * 100 / COUNT(0), 2) AS pct_caption,
  ROUND(COUNTIF('thead' IN UNNEST(table_elements)) * 100 / COUNT(0), 2) AS pct_thead
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    getTableElements(payload) AS table_elements
  FROM
    `httparchive.pages.2019_07_01_*`)
WHERE
  'table' IN UNNEST(table_elements)
GROUP BY
  client
