#standardSQL
# 07_12: Percentiles of largest image
SELECT
  percentile,
  client,
  ROUND(APPROX_QUANTILES(largest_image, 1000)[OFFSET(percentile * 10)] / 1000, 2) AS largest_image
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    CAST(JSON_EXTRACT(payload, "$['_heroElementTimes.Image']") AS INT64) AS largest_image
  FROM
    `httparchive.pages.2019_07_01_*`
),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
