WITH lcp AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    JSON_VALUE(payload, '$._performance.lcp_resource.initiator.url') AS url
  FROM
    `httparchive.pages.2022_06_01_*`
  WHERE
    JSON_VALUE(payload, '$._performance.is_lcp_statically_discoverable') != 'true'
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
),

totals AS (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2022_06_01_*`
  GROUP BY
    client
)


SELECT
  client,
  IFNULL(type, 'unknown') AS lcp_initiator_type,
  COUNT(0) AS pages,
  ANY_VALUE(total) AS total,
  COUNT(0) / ANY_VALUE(total) AS pct
FROM
  totals
JOIN
  lcp
USING
  (client)
LEFT JOIN
  requests
USING
  (client, page, url)
GROUP BY
  client,
  type
ORDER BY
  pct DESC
