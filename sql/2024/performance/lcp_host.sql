WITH lcp AS (
  SELECT
    client,
    page,
    JSON_VALUE(custom_metrics, '$.performance.lcp_elem_stats.url') AS url
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01' AND
    is_root_page
)


SELECT
  client,
  CASE
    WHEN NET.HOST(url) = 'data' THEN 'other content'
    WHEN NET.HOST(url) IS NULL THEN 'other content'
    WHEN NET.HOST(page) = NET.HOST(url) THEN 'same host'
    ELSE 'cross host'
  END AS lcp_same_host,
  COUNT(*) AS pages,
  SUM(COUNT(*)) OVER (PARTITION BY client) AS total,
  COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY client) AS pct
FROM
  lcp
GROUP BY
  client,
  lcp_same_host
