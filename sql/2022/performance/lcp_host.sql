WITH lcp AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    JSON_VALUE(payload, '$._performance.lcp_elem_stats.url') AS lcp_url
  FROM
    `httparchive.pages.2022_06_01_*`
),

hosts AS (
  SELECT
    client,
    NET.HOST(page) = NET.HOST(lcp_url) AS lcp_same_host
  FROM
    lcp
  WHERE
    lcp_url IS NOT NULL
)

SELECT
  client,
  COUNTIF(lcp_same_host) AS lcp_same_host,
  COUNT(0) AS total,
  COUNTIF(lcp_same_host) / COUNT(0) AS pct_lcp_same_host
FROM
  hosts
GROUP BY
  client
