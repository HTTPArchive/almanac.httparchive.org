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


-- WITH
--   summary_pages AS (
--     SELECT * FROM `httparchive.summary_pages.2019_07_01_desktop`
--     UNION ALL
--     SELECT * FROM `httparchive.summary_pages.2019_07_01_mobile`
--   ),
--   summary_requests AS (
--     SELECT * FROM `httparchive.summary_requests.2019_07_01_desktop`
--     UNION ALL
--     SELECT * FROM `httparchive.summary_requests.2019_07_01_mobile`
--   ),
--   merge_table AS (
--     SELECT * FROM summary_requests JOIN (
--       SELECT pageid, url AS page_url FROM summary_pages
--     ) USING (pageid)
--   ),
--   processedTable AS (
--     SELECT (NET.HOST(url) != NET.HOST(page_url)) as hosted, url, page_url
--     FROM merge_table WHERE type = 'font'
--   )
-- SELECT value AS host, count
-- FROM (
--   SELECT APPROX_TOP_COUNT(NET.HOST(url), 500) AS font_host
--   FROM processedTable
--   WHERE hosted = true
-- ), UNNEST(font_host)
