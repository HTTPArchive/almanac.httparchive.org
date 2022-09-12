CREATE TEMPORARY FUNCTION getTableSizes(json STRING)
RETURNS ARRAY<STRUCT <key STRING, value INT64>>
LANGUAGE js AS '''
if (json === null) {
  return [];
}

try {
  const sizes = JSON.parse(json);
  return Object.entries(sizes).map(([key, value]) => ({ key, value }));
} catch (e) {
  return [];
}
''';

WITH
fonts AS (
  SELECT
    url,
    JSON_EXTRACT(payload, '$._font_details.table_sizes') AS payload
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2022-06-01' AND
    type = 'font'
  GROUP BY
    url,
    payload
)

SELECT
  percentile,
  table,
  COUNT(0) AS total,
  APPROX_QUANTILES(bytes, 1000)[OFFSET(percentile * 10)] AS bytes
FROM (
  SELECT
    percentile,
    key AS table,
    value AS bytes
  FROM
    fonts,
    UNNEST(getTableSizes(payload)) AS table,
    UNNEST([10, 25, 50, 75, 90, 100]) AS percentile)
GROUP BY
  table,
  percentile
ORDER BY
  table,
  percentile
