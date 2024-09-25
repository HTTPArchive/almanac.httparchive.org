WITH lcp AS (
  SELECT
    client,
    rank,
    page,
    JSON_VALUE(custom_metrics, '$.performance.is_lcp_statically_discoverable') = 'true' AS discoverable,
    JSON_VALUE(custom_metrics, '$.performance.is_lcp_preloaded') = 'true' AS preloaded
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01' AND
    is_root_page
)


SELECT
  client,
  page,
  discoverable,
  preloaded
FROM
  lcp
WHERE
  rank <= 1000 AND
  discoverable = false AND
  preloaded = false
LIMIT
  10
