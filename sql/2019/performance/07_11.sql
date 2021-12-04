#standardSQL
# 07_11: Percentiles of H1 rendering time
SELECT
  percentile,
  client,
  ROUND(APPROX_QUANTILES(h1_rendered, 1000)[OFFSET(percentile * 10)] / 1000, 2) AS h1_rendered
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    CAST(JSON_EXTRACT(payload, "$['_heroElementTimes.Heading']") AS INT64) AS h1_rendered
  FROM
    `httparchive.pages.2019_07_01_*`),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
