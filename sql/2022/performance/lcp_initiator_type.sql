WITH lcp AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    JSON_VALUE(payload, '$._performance.lcp_resource.initiator.url') AS url,
    JSON_VALUE(payload, '$._performance.is_lcp_statically_discoverable') = 'false' AS not_discoverable
  FROM
    `httparchive.pages.2022_06_01_*`
),

requests AS (
  SELECT
    client,
    page,
    url,
    type
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2022-06-01'
)

SELECT
  client,
  type AS lcp_initiator_type,
  COUNTIF(not_discoverable) AS pages,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNTIF(not_discoverable) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  lcp
JOIN
  requests
USING (client, page, url)
GROUP BY
  client,
  type
ORDER BY
  pct DESC
