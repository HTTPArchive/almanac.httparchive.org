#standardSQL
-- % of sites whose robots.txt returns 200 and includes any directive, therefor the percentage is smaller (75% instead of 95% reported elswhere)
WITH roots AS (
  SELECT
    client,
    root_page,
    SAFE_CAST(JSON_VALUE(custom_metrics.robots_txt, '$.status') AS INT64) AS status,
    COALESCE(SAFE_CAST(JSON_VALUE(custom_metrics.robots_txt.record_counts.by_type, '$.allow') AS INT64), 0) AS allow_cnt,
    COALESCE(SAFE_CAST(JSON_VALUE(custom_metrics.robots_txt.record_counts.by_type, '$.disallow') AS INT64), 0) AS disallow_cnt,
    COALESCE(SAFE_CAST(JSON_VALUE(custom_metrics.robots_txt.record_counts.by_type, '$.crawl_delay') AS INT64), 0) AS crawl_delay_cnt,
    COALESCE(SAFE_CAST(JSON_VALUE(custom_metrics.robots_txt.record_counts.by_type, '$.noindex') AS INT64), 0) AS noindex_cnt,
    COALESCE(SAFE_CAST(JSON_VALUE(custom_metrics.robots_txt.record_counts.by_type, '$.sitemap') AS INT64), 0) AS sitemap_cnt,
    COALESCE(SAFE_CAST(JSON_VALUE(custom_metrics.robots_txt.record_counts.by_type, '$.user_agent') AS INT64), 0) AS ua_cnt
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01' AND
    is_root_page
)

SELECT
  client,
  COUNT(DISTINCT root_page) AS sites,
  COUNT(DISTINCT IF(
    status = 200 AND
    (allow_cnt + disallow_cnt + crawl_delay_cnt + noindex_cnt + sitemap_cnt + ua_cnt) > 0,
    root_page, NULL
  )) AS sites_with_robots_txt,
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
      status = 200 AND
      (allow_cnt + disallow_cnt + crawl_delay_cnt + noindex_cnt + sitemap_cnt + ua_cnt) > 0,
      root_page, NULL
    )),
    COUNT(DISTINCT root_page)
  ) AS pct_sites_with_robots_txt
FROM
  roots
GROUP BY
  client
ORDER BY
  client;
