#standardSQL
# 07_20: Percentiles of scripting CPU time
#corresponding to the time main thread of the browser was busy
SELECT
  percentile,
  client,
  ROUND(APPROX_QUANTILES(script_cpu_time, 1000)[OFFSET(percentile * 10)] / 1000, 2) AS script_cpu_time
FROM (
  SELECT
    _TABLE_SUFFIX AS client, (
      CAST(IFNULL(JSON_EXTRACT(payload, "$['_cpu.EvaluateScript']"), '0') AS INT64) +
      CAST(IFNULL(JSON_EXTRACT(payload, "$['_cpu.XHRLoad']"), '0') AS INT64) +
      CAST(IFNULL(JSON_EXTRACT(payload, "$['_cpu.XHRReadyStateChange']"), '0') AS INT64) +
      CAST(IFNULL(JSON_EXTRACT(payload, "$['_cpu.TimerFire']"), '0') AS INT64) +
      CAST(IFNULL(JSON_EXTRACT(payload, "$['_cpu.EventDispatch']"), '0') AS INT64) +
      CAST(IFNULL(JSON_EXTRACT(payload, "$['_cpu.FunctionCall']"), '0') AS INT64) +
      CAST(IFNULL(JSON_EXTRACT(payload, "$['_cpu.v8.compile']"), '0') AS INT64) +
      CAST(IFNULL(JSON_EXTRACT(payload, "$['_cpu.MinorGC']"), '0') AS INT64) +
      CAST(IFNULL(JSON_EXTRACT(payload, "$['_cpu.FireAnimationFrame']"), '0') AS INT64) +
      CAST(IFNULL(JSON_EXTRACT(payload, "$['_cpu.MajorGC']"), '0') AS INT64)
    ) AS script_cpu_time
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
