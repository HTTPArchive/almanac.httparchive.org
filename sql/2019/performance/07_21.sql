#standardSQL
# 07_21: Percentiles of layout CPU time
#corresponding to the time main thread of the browser was busy
SELECT
  percentile,
  client,
  ROUND(APPROX_QUANTILES(layout_cpu_time, 1000)[OFFSET(percentile * 10)] / 1000, 2) AS layout_cpu_time
FROM (
  SELECT
  _TABLE_SUFFIX AS client,
  (
    CAST(IFNULL(JSON_EXTRACT(payload, "$['_cpu.ParseAuthorStyleSheet']"), "0") AS INT64) +
    CAST(IFNULL(JSON_EXTRACT(payload, "$['_cpu.Layout']"), "0") AS INT64) +
    CAST(IFNULL(JSON_EXTRACT(payload, "$['_cpu.UpdateLayoutTree']"), "0") AS INT64)
  ) AS layout_cpu_time
  FROM
   `httparchive.pages.2019_07_01_*`),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
