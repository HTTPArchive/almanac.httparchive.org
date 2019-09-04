#standardSQL

-- counts the host_url of a given font

SELECT
  font_host.value AS host,
  font_host.count / total_requests AS pct_requests
FROM (
  SELECT
    APPROX_TOP_COUNT(NET.HOST(url), 500) AS font_host,
    COUNT(DISTINCT url) AS total_requests
  FROM
    (SELECT _TABLE_SUFFIX, pageid, url FROM `httparchive.summary_requests.2019_07_01_*` WHERE type = 'font')
  JOIN
    (SELECT _TABLE_SUFFIX, pageid, url AS page FROM `httparchive.summary_pages.2019_07_01_*`)
  USING (_TABLE_SUFFIX, pageid)
  WHERE NET.HOST(url) != NET.HOST(page)),
UNNEST(font_host) AS font_host
