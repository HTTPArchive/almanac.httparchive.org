#standardSQL
# 07_22: Percentiles of paint CPU time
#where the main thread of the browser was busy
SELECT
  client,
  ROUND(APPROX_QUANTILES(paintCpuTime, 1000)[OFFSET(100)] / 1000, 2) AS p10,
  ROUND(APPROX_QUANTILES(paintCpuTime, 1000)[OFFSET(250)] / 1000, 2) AS p25,
  ROUND(APPROX_QUANTILES(paintCpuTime, 1000)[OFFSET(500)] / 1000, 2) AS p50,
  ROUND(APPROX_QUANTILES(paintCpuTime, 1000)[OFFSET(750)] / 1000, 2) AS p75,
  ROUND(APPROX_QUANTILES(paintCpuTime, 1000)[OFFSET(900)] / 1000, 2) AS p90
FROM 
( 
  SELECT 
  _TABLE_SUFFIX AS client,
  (
    CAST(IFNULL(JSON_EXTRACT(payload, "$['_cpu.Paint']"), "0") AS INT64) +
    CAST(IFNULL(JSON_EXTRACT(payload, "$['_cpu.UpdateLayerTree']"), "0") as INT64)
  ) AS paintCpuTime
  FROM
   `httparchive.pages.2019_07_01_*` 
)
GROUP BY
  client
