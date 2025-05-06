WITH lcp AS (
  SELECT
    client,
    JSON_VALUE(custom_metrics, '$.performance.is_lcp_statically_discoverable') = 'true' AS discoverable,
    JSON_VALUE(custom_metrics, '$.performance.is_lcp_preloaded') = 'true' AS preloaded
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2023-10-01' AND
    is_root_page
)

SELECT
  client,
  discoverable,
  preloaded,
  COUNT(0) AS pages,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  lcp
GROUP BY
  client,
  discoverable,
  preloaded
ORDER BY
  pct DESC
