WITH lcp AS (
  SELECT
    _TABLE_SUFFIX AS client,
    JSON_VALUE(payload, '$._performance.is_lcp_statically_discoverable') = 'true' AS discoverable,
    JSON_VALUE(payload, '$._performance.is_lcp_preloaded') = 'true' AS preloaded
  FROM
    `httparchive.pages.2022_06_01_*`
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
