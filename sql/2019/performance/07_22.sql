#standardSQL
# 07_22: Percentiles of paint CPU time
#where the main thread of the browser was busy
SELECT
  percentile,
  client,
  APPROX_QUANTILES(paint_cpu_time, 1000)[OFFSET(percentile * 10)] AS paint_cpu_time
FROM (
  SELECT
  _TABLE_SUFFIX AS client,
  (
    CAST(IFNULL(JSON_EXTRACT(payload, "$['_cpu.Paint']"), "0") AS INT64) +
    CAST(IFNULL(JSON_EXTRACT(payload, "$['_cpu.UpdateLayerTree']"), "0") AS INT64)
  ) AS paint_cpu_time
  FROM
   `httparchive.pages.2019_07_01_*`),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
