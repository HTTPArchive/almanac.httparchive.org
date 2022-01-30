#standardSQL
# 16_04b: Difference between Cache TTL and the contents age
CREATE TEMPORARY FUNCTION toTimestamp(date_string STRING)
RETURNS INT64 LANGUAGE js AS '''
  try {
    var timestamp = Math.round(new Date(date_string).getTime() / 1000);
    return isNaN(timestamp) ? -1 : timestamp;
  } catch (e) {
    return -1;
  }
''';

SELECT
  client,
  percentile,
  APPROX_QUANTILES(diff_in_days, 1000)[OFFSET(percentile * 10)] AS diff_in_days
FROM
  (
    SELECT
      client,
      ROUND((expAge - (startedDateTime - toTimestamp(resp_last_modified))) / 86400, 2) AS diff_in_days
    FROM
      `httparchive.almanac.requests`
    WHERE
      date = '2019-07-01' AND
      resp_last_modified != "" AND expAge > 0
  ),
  UNNEST([10, 20, 30, 40, 50, 60, 70, 80, 90]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
