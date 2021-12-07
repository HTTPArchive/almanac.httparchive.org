#standardSQL
# 04_14: Distribution of image network setup times
CREATE TEMPORARY FUNCTION getNetworkSetupTime(payload STRING)
RETURNS INT64 LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var timings = $.timings;
  var time = -1;
  if (timings.dns >= 1) time += timings.dns;
  if (timings.connect >= 1) time += timings.connect;
  if (timings.ssl >= 1) time += timings.ssl;
  return time >= 0 ? time : null;
} catch (e) {
  return null;
}
''';

SELECT
  percentile,
  client,
  APPROX_QUANTILES(getNetworkSetupTime(payload), 1000)[OFFSET(percentile * 10)] AS network_setup_time
FROM
  `httparchive.almanac.requests`,
  UNNEST([10, 25, 50, 75, 90]) AS percentile
WHERE
  date = '2019-07-01' AND
  type = 'image'
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
