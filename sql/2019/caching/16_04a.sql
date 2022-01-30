#standardSQL
# 16_04a: Requests with a content age older than its TTL
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
  COUNT(0) AS total_req,
  COUNTIF(diff < 0) AS req_too_short_cache,
  ROUND(COUNTIF(diff < 0) * 100 / COUNT(0), 2) AS perc_req_too_short_cache
FROM
  (
    SELECT
      client,
      expAge - (startedDateTime - toTimestamp(resp_last_modified)) AS diff
    FROM
      `httparchive.almanac.requests`
    WHERE
      date = '2019-07-01' AND
      resp_last_modified != "" AND
      expAge > 0
  )
GROUP BY
  client
