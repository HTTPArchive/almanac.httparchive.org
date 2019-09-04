#standardSQL

-- counts the local and hosted fonts

SELECT
  COUNTIF(NET.HOST(page) != NET.HOST(url)) / COUNT(0) AS hosted,
  COUNTIF(NET.HOST(page) = NET.HOST(url)) / COUNT(0) AS local
FROM
  (SELECT _TABLE_SUFFIX, pageid, url FROM `httparchive.summary_requests.2019_07_01_*` WHERE type = 'font')
JOIN
  (SELECT _TABLE_SUFFIX, pageid, url AS page FROM `httparchive.summary_pages.2019_07_01_*`)
USING (_TABLE_SUFFIX, pageid)
