-- Section: Performance
-- Question: What is the distribution of the file size broken down by table?
-- Normalization: Fonts

CREATE TEMPORARY FUNCTION TABLES(json STRING)
RETURNS ARRAY<STRUCT<name STRING, size INT64>>
LANGUAGE js AS '''
try {
  const $ = JSON.parse(json);
  return Object.entries($).map(([name, size]) => ({ name, size }));
} catch (e) {
  return [];
}
''';

WITH
fonts AS (
  SELECT
    client,
    url,
    TABLES(JSON_EXTRACT(ANY_VALUE(payload), '$._font_details.table_sizes')) AS tables
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND
    type = 'font' AND
    is_root_page
  GROUP BY
    client,
    url
)

SELECT
  client,
  table.name AS table,
  percentile,
  COUNT(0) AS count,
  ROUND(APPROX_QUANTILES(size, 1000)[OFFSET(percentile * 10)]) AS size
FROM
  fonts,
  UNNEST(tables) AS table,
  UNNEST([10, 25, 50, 75, 90, 99]) AS percentile
GROUP BY
  client,
  table,
  percentile
HAVING
  -- Filter out spurious tables.
  count > 1000
ORDER BY
  client,
  table,
  percentile
