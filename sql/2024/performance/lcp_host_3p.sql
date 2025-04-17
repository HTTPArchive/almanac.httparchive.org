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
  NET.REG_DOMAIN(url) AS lcp_domain,
  COUNT(0) AS pages,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  lcp
WHERE
  NET.HOST(page) != NET.HOST(url) AND
  NET.HOST(url) != 'data'
GROUP BY
  client,
  lcp_domain
ORDER BY
  pct DESC
LIMIT
  25
