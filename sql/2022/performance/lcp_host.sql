WITH lcp AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    JSON_VALUE(payload, '$._performance.lcp_elem_stats.url') AS url
  FROM
    `httparchive.pages.2022_06_01_*`
)

SELECT
  client,
  CASE
    WHEN NET.HOST(url) = 'data' THEN 'other content'
    WHEN NET.HOST(url) IS NULL THEN 'other content'
    WHEN NET.HOST(page) = NET.HOST(url) THEN 'same host'
    ELSE 'cross host'
  END AS lcp_same_host,
  COUNT(0) AS pages,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  lcp
GROUP BY
  client,
  lcp_same_host
