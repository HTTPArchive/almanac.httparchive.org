#standardSQL
# Difference between Cache TTL and the contents age
CREATE TEMPORARY FUNCTION toTimestamp(date_string STRING)
RETURNS INT64 LANGUAGE js AS '''
  try {
    var timestamp = Math.round(new Date(date_string).getTime() / 1000);
    return isNaN(timestamp) || timestamp < 0 ? -1 : timestamp;
  } catch (e) {
    return null;
  }
''';

SELECT
  client,
  percentile,
  APPROX_QUANTILES(diff_in_days, 1000 IGNORE NULLS)[OFFSET(percentile * 10)] AS diff_in_days
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    ROUND((expAge - (startedDateTime - toTimestamp(resp_last_modified))) / (60 * 60 * 24), 2) AS diff_in_days
  FROM
    `httparchive.summary_requests.2020_08_01_*`
  WHERE
    resp_last_modified != '' AND
    expAge > 0
),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  client,
  percentile
ORDER BY
  client,
  percentile
