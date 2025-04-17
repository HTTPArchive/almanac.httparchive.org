WITH lcp AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    JSON_VALUE(payload, '$._performance.lcp_resource.initiator.url') AS url,
    COUNT(0) OVER (PARTITION BY _TABLE_SUFFIX) AS total
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
  COUNT(0) AS pages,
  ANY_VALUE(total) AS total,
  COUNT(0) / ANY_VALUE(total) AS pct
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
