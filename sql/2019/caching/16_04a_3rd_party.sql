#standardSQL
# 16_04a_3rd_party: Requests with a content age older than its TTL by party
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
  party,
  COUNT(0) AS total_req,
  COUNTIF(diff < 0) AS req_too_short_cache,
  ROUND(COUNTIF(diff < 0) * 100 / COUNT(0), 2) AS perc_req_too_short_cache
FROM (
  SELECT
    client,
    IF(STRPOS(NET.HOST(url), REGEXP_EXTRACT(NET.REG_DOMAIN(page), r'([\w-]+)')) > 0, 1, 3) AS party,
    expAge - (startedDateTime - toTimestamp(resp_last_modified)) AS diff
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2019-07-01' AND
    resp_last_modified != '' AND
    expAge > 0
)
GROUP BY
  client,
  party
ORDER BY
  client,
  party
