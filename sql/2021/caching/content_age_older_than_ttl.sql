#standardSQL
# Requests with a content age older than its TTL
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
  COUNT(0) AS total_req,
  COUNTIF(diff < 0) AS req_too_short_cache,
  COUNTIF(diff < 0) / COUNT(0) AS perc_req_too_short_cache
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    expAge - (startedDateTime - toTimestamp(resp_last_modified)) AS diff
  FROM
    `httparchive.summary_requests.2021_07_01_*`
  WHERE
    resp_last_modified != '' AND
    expAge > 0
)
GROUP BY
  client
ORDER BY
  client
