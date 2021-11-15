#standardSQL
# % of pages using each input element attribute
CREATE TEMPORARY FUNCTION getUsedAttributes(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  const almanac = JSON.parse(payload);
  return Object.keys(almanac.input_elements.attribute_usage_count);
} catch (e) {
  return [];
}
''';
SELECT
  _TABLE_SUFFIX AS client,
  total_pages,
  attribute,
  COUNT(0) AS total_pages_using,
  COUNT(0) / total_pages AS pct_pages_using
FROM
  `httparchive.pages.2021_07_01_*`,
  UNNEST(getUsedAttributes(JSON_EXTRACT_SCALAR(payload, '$._almanac'))) AS attribute
LEFT JOIN (
  SELECT
    _TABLE_SUFFIX,
    COUNT(0) AS total_pages
  FROM
    `httparchive.pages.2021_07_01_*`
  GROUP BY _TABLE_SUFFIX
)
USING (_TABLE_SUFFIX)
GROUP BY
  client,
  attribute,
  total_pages
HAVING
  total_pages_using >= 100
ORDER BY
  pct_pages_using DESC
