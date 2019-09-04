#standardSQL

-- counts the host_url of a given font

SELECT
  APPROX_TOP_COUNT(NET.HOST(url), 500) AS font_host
FROM
  (SELECT
    (NET.HOST(url) != NET.HOST(page)) as hosted, url, page
  FROM
    (SELECT _TABLE_SUFFIX, pageid, url FROM `httparchive.summary_requests.2019_07_01_*` WHERE type = 'font')
  JOIN
    (SELECT _TABLE_SUFFIX, pageid, url AS page FROM `httparchive.summary_pages.2019_07_01_*`)
  USING (_TABLE_SUFFIX, pageid)
  )
WHERE hosted = true
