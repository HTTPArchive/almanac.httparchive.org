#standardSQL
# Age of resources party, type wise.
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
  IF (STRPOS(NET.HOST(requests.url), REGEXP_EXTRACT(NET.REG_DOMAIN(pages.url), r'([\w-]+)')) > 0, 1, 3) AS party,
  requests.type AS resource_type,
  ROUND((requests.startedDateTime - toTimestamp(requests.resp_last_modified)) / (86400 * 7)) AS age_weeks,
  COUNT(0) AS total_requests,
FROM 
  `httparchive.summary_requests.2020_08_01_desktop` requests
JOIN 
  `httparchive.summary_pages.2020_08_01_desktop` pages
ON 
  requests.pageid = pages.pageid
WHERE 
  TRIM(requests.resp_last_modified) <> ""
GROUP BY 
  party, 
  resource_type,
  age_weeks
ORDER BY
  resource_type, 
  party, 
  age_weeks
