#standardSQL
# pages almanac metrics grouped by device and element attribute use (frequency)

CREATE TEMPORARY FUNCTION get_almanac_attribute_info(attributes_used_on_elements JSON)
RETURNS ARRAY<STRUCT<name STRING, freq INT64>> LANGUAGE js AS '''
if (attributes_used_on_elements) {
  return Object.entries(attributes_used_on_elements).map(([name, freq]) => ({name, freq}));
}
return [];
''';

WITH totals AS (
  SELECT
    client,
    COUNT(0) AS total
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'
  GROUP BY
    client
)

SELECT
  client,
  almanac_attribute_info.name,
  COUNT(DISTINCT page) AS pages,
  ANY_VALUE(total) AS total_pages,
  COUNT(DISTINCT page) / ANY_VALUE(total) AS pct_pages,
  SUM(almanac_attribute_info.freq) AS freq,
  SUM(SUM(almanac_attribute_info.freq)) OVER (PARTITION BY client) AS total,
  SUM(almanac_attribute_info.freq) / SUM(SUM(almanac_attribute_info.freq)) OVER (PARTITION BY client) AS pct_ratio
FROM
  `httparchive.crawl.pages`,
  UNNEST(get_almanac_attribute_info(custom_metrics.other.almanac.attributes_used_on_elements)) AS almanac_attribute_info
JOIN
  totals
USING (client)
WHERE
  date = '2025-07-01'
GROUP BY
  client,
  almanac_attribute_info.name
ORDER BY
  pct_ratio DESC
LIMIT
  1000
