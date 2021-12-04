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
  app AS js_framework,
  COUNT(DISTINCT page) AS pages,
  APPROX_QUANTILES(v8_time, 1000)[OFFSET(percentile * 10)] AS v8_time
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    totalMainThreadTime(payload) AS v8_time
  FROM
    `httparchive.pages.2020_08_01_*`)
JOIN (
  SELECT DISTINCT
    _TABLE_SUFFIX AS client,
    url AS page,
    app
  FROM
    `httparchive.technologies.2020_08_01_*`
  WHERE
    category = 'JavaScript frameworks')
USING
  (client, page),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client,
  js_framework
ORDER BY
  percentile,
  client,
  pages DESC
