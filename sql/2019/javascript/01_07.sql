#standardSQL
# 01_07: Cumulative V8 main thread time
CREATE TEMPORARY FUNCTION totalMainThreadTime(payload STRING)
RETURNS FLOAT64 LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  return Object.values($._v8Stats.main_thread).reduce((sum, i) => sum + i, 0);
} catch (e) {
  return null;
}
''';

SELECT
  client,
  ROUND(APPROX_QUANTILES(v8_time, 1000)[OFFSET(100)], 3) AS p10,
  ROUND(APPROX_QUANTILES(v8_time, 1000)[OFFSET(250)], 3) AS p25,
  ROUND(APPROX_QUANTILES(v8_time, 1000)[OFFSET(500)], 3) AS p50,
  ROUND(APPROX_QUANTILES(v8_time, 1000)[OFFSET(750)], 3) AS p75,
  ROUND(APPROX_QUANTILES(v8_time, 1000)[OFFSET(900)], 3) AS p90
FROM (
  SELECT _TABLE_SUFFIX AS client, totalMainThreadTime(payload) AS v8_time FROM `httparchive.pages.2019_07_01_*`
)
GROUP BY
  client
