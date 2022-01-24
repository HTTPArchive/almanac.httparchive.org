#standardSQL
# Difference between Cache TTL and the content age for third party request
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
  party,
  COUNT(0) AS total_req,
  COUNTIF(diff < 0) AS req_too_short_cache,
  COUNTIF(diff < 0) / COUNT(0) AS perc_req_too_short_cache
FROM
  (
    SELECT
      "desktop" AS client,
      IF(NET.HOST(url) IN (
        SELECT domain FROM `httparchive.almanac.third_parties` WHERE date = '2020-08-01' AND category != 'hosting'
      ), 'third party', 'first party') AS party,
      requests.expAge - (requests.startedDateTime - toTimestamp(requests.resp_last_modified)) AS diff
    FROM
      `httparchive.summary_requests.2020_08_01_desktop` requests
    WHERE
      TRIM(requests.resp_last_modified) != "" AND
      expAge > 0
    UNION ALL
    SELECT
      "mobile" AS client,
      IF(NET.HOST(url) IN (
        SELECT domain FROM `httparchive.almanac.third_parties` WHERE date = '2020-08-01' AND category != 'hosting'
      ), 'third party', 'first party') AS party,
      requests.expAge - (requests.startedDateTime - toTimestamp(requests.resp_last_modified)) AS diff
    FROM
      `httparchive.summary_requests.2020_08_01_mobile` requests
    WHERE
      TRIM(requests.resp_last_modified) != "" AND
      expAge > 0
  )
GROUP BY
  client,
  party
ORDER BY
  client,
  party
