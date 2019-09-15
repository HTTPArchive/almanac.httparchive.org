#standardSQL
# 07_20: Percentiles of scripting CPU time
#corresponding to the time main thread of the browser was busy
SELECT
  client,
  ROUND(APPROX_QUANTILES(scriptingCpuTime, 1000)[OFFSET(100)] / 1000, 2) AS p10,
  ROUND(APPROX_QUANTILES(scriptingCpuTime, 1000)[OFFSET(250)] / 1000, 2) AS p25,
  ROUND(APPROX_QUANTILES(scriptingCpuTime, 1000)[OFFSET(500)] / 1000, 2) AS p50,
  ROUND(APPROX_QUANTILES(scriptingCpuTime, 1000)[OFFSET(750)] / 1000, 2) AS p75,
  ROUND(APPROX_QUANTILES(scriptingCpuTime, 1000)[OFFSET(900)] / 1000, 2) AS p90
FROM 
( 
  SELECT 
  _TABLE_SUFFIX AS client,
  (
    CAST(IFNULL(JSON_EXTRACT(payload, "$['_cpu.EvaluateScript']"), "0") AS INT64) +
    CAST(IFNULL(JSON_EXTRACT(payload, "$['_cpu.XHRLoad']"), "0") as INT64) +
    CAST(IFNULL(JSON_EXTRACT(payload, "$['_cpu.XHRReadyStateChange']"), "0") AS INT64) +
    CAST(IFNULL(JSON_EXTRACT(payload, "$['_cpu.TimerFire']"), "0") as INT64) +
    CAST(IFNULL(JSON_EXTRACT(payload, "$['_cpu.EventDispatch']"), "0") AS INT64) +
    CAST(IFNULL(JSON_EXTRACT(payload, "$['_cpu.FunctionCall']"), "0") AS INT64) +
    CAST(IFNULL(JSON_EXTRACT(payload, "$['_cpu.v8.compile']"), "0") AS INT64) +
    CAST(IFNULL(JSON_EXTRACT(payload, "$['_cpu.MinorGC']"), "0") AS INT64) +
    CAST(IFNULL(JSON_EXTRACT(payload, "$['_cpu.FireAnimationFrame']"), "0") AS INT64) +
    CAST(IFNULL(JSON_EXTRACT(payload, "$['_cpu.MajorGC']"), "0") AS INT64)
  ) AS scriptingCpuTime
  FROM
   `httparchive.pages.2019_07_01_*`
)
GROUP BY
  client
