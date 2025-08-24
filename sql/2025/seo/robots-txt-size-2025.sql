#standardSQL
# Robots.txt size
SELECT
  client,
  COUNT(DISTINCT(site)) AS sites,
  SAFE_DIVIDE(COUNTIF(robots_size = 0), COUNT(DISTINCT(site))) AS pct_0,
  SAFE_DIVIDE(COUNTIF(robots_size > 0 AND robots_size <= 100), COUNT(DISTINCT(site))) AS pct_0_100,
  SAFE_DIVIDE(COUNTIF(robots_size > 100 AND robots_size <= 200), COUNT(DISTINCT(site))) AS pct_100_200,
  SAFE_DIVIDE(COUNTIF(robots_size > 200 AND robots_size <= 300), COUNT(DISTINCT(site))) AS pct_200_300,
  SAFE_DIVIDE(COUNTIF(robots_size > 300 AND robots_size <= 400), COUNT(DISTINCT(site))) AS pct_300_400,
  SAFE_DIVIDE(COUNTIF(robots_size > 400 AND robots_size <= 500), COUNT(DISTINCT(site))) AS pct_400_500,
  SAFE_DIVIDE(COUNTIF(robots_size > 500), COUNT(DISTINCT(site))) AS pct_gt500,
  SAFE_DIVIDE(COUNTIF(robots_size IS NULL), COUNT(DISTINCT(site))) AS pct_missing,
  COUNTIF(robots_size > 500) AS count_gt500,
  COUNTIF(robots_size IS NULL) AS count_missing
FROM (
  SELECT
    client,
    root_page AS site,
    custom_metrics.robots_txt,
    FLOAT64(custom_metrics.robots_txt.size_kib) AS robots_size
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01' AND
    is_root_page AND -- no need to crawl inner pages for this one
    custom_metrics.robots_txt.status IS NOT NULL
)
GROUP BY
  client
ORDER BY
  client DESC
