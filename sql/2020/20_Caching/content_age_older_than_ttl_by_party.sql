#standardSQL
# Difference between Cache TTL and the content age for third party request
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
  COUNTIF(diff < 0) / COUNT(0) AS perc_req_too_short_cache
FROM
   (
     SELECT
       "desktop" AS client,
       IF(STRPOS(NET.HOST(requests.url), REGEXP_EXTRACT(NET.HOST(pages.url), r'([\w-]+)'))>0, 1, 3) AS party,
       requests.expAge - (requests.startedDateTime - toTimestamp(requests.resp_last_modified)) AS diff
     FROM
       `httparchive.summary_requests.2020_08_01_desktop` requests
     JOIN
       `httparchive.summary_pages.2020_08_01_desktop` pages
     ON
       pages.pageid = requests.pageid 
     WHERE
       TRIM(requests.resp_last_modified) <> "" AND
       expAge > 0
     UNION ALL
     SELECT
       "mobile" AS client,
       IF(STRPOS(NET.HOST(requests.url), REGEXP_EXTRACT(NET.HOST(pages.url), r'([\w-]+)'))>0, 1, 3) AS party,
       requests.expAge - (requests.startedDateTime - toTimestamp(requests.resp_last_modified)) AS diff
     FROM
       `httparchive.summary_requests.2020_08_01_mobile` requests
     JOIN
       `httparchive.summary_pages.2020_08_01_mobile` pages
     ON
       pages.pageid = requests.pageid 
     WHERE
       TRIM(requests.resp_last_modified) <> "" AND
       expAge > 0
  )
GROUP BY
  client,
  party
ORDER BY
  client,
  party
