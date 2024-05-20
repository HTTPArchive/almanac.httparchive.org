#standardSQL
# Cumulative V8 main thread time
CREATE TEMPORARY FUNCTION totalMainThreadTime(payload STRING) RETURNS FLOAT64 LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  return Object.values($._v8Stats.main_thread).reduce((sum, i) => sum + i, 0);
} catch (e) {
  return null;
}
''';

SELECT
  percentile,
  client,
  APPROX_QUANTILES(v8_time, 1000)[OFFSET(percentile * 10)] AS v8_time
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    totalMainThreadTime(payload) AS v8_time
  FROM
    `httparchive.pages.2020_08_01_*`
),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
