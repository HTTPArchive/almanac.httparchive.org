#standardSQL
# Section: Transpont Security - Protocol versions
# Question: How many websites (home pages only) use HTTP vs HTTPS?
SELECT
  client,
  STARTS_WITH(page, 'https') AS https,
  COUNT(0) AS pages,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  `httparchive.crawl.requests`
WHERE
  date = '2025-07-01' AND
  is_root_page AND
  is_main_document
GROUP BY
  client,
  https
