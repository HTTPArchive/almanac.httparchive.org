-- Section: Performance
-- Question: What is the distribution of the file size broken down by table?

CREATE TEMPORARY FUNCTION TABLES(json STRING)
RETURNS ARRAY<STRUCT<name STRING, value INT64>>
LANGUAGE js AS '''
if (json === null) {
  return [];
}
try {
  const $ = JSON.parse(json);
  return Object.entries($).map(([name, value]) => ({ name, value }));
} catch (e) {
  return [];
}
''';

WITH
fonts AS (
  SELECT
    client,
    url,
    JSON_EXTRACT(ANY_VALUE(payload), '$._font_details.table_sizes') AS payload
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND
    type = 'font'
  GROUP BY
    client,
    url
),
tables AS (
  SELECT
    client,
    table.name AS table,
    table.value AS size
  FROM
    fonts,
    UNNEST(TABLES(payload)) AS table
)

SELECT
  client,
  table,
  percentile,
  COUNT(0) AS count,
  APPROX_QUANTILES(size, 1000)[OFFSET(percentile * 10)] AS size
FROM
  tables,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  client,
  table,
  percentile
ORDER BY
  client,
  table,
  percentile