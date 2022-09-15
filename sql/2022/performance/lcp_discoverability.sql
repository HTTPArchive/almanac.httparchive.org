WITH discoverability AS (
  SELECT
    _TABLE_SUFFIX AS client,
    JSON_VALUE(payload, '$._performance.is_lcp_statically_discoverable') = 'true' AS is_discoverable
  FROM
    `httparchive.pages.2022_06_01_*`
)

SELECT
  client,
  COUNTIF(is_discoverable) AS is_discoverable,
  COUNT(0) AS total,
  COUNTIF(is_discoverable) / COUNT(0) AS pct_discoverable
FROM
  discoverability
WHERE
  is_discoverable IS NOT NULL
GROUP BY
  client
