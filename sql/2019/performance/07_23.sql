#standardSQL
# 07_23: Percentiles of loading CPU time
#where the main thread of the browser was busy
SELECT
  percentile,
  client,
  APPROX_QUANTILES(loading_cpu_time, 1000)[OFFSET(100)] AS loading_cpu_time
FROM (
  SELECT
  _TABLE_SUFFIX AS client,
  (
    CAST(IFNULL(JSON_EXTRACT(payload, "$['_cpu.ParseHTML']"), "0") AS INT64)
  ) AS loading_cpu_time
  FROM
   `httparchive.pages.2019_07_01_*`),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
