WITH lcp AS (
  SELECT
    client,
    page,
    JSON_VALUE(custom_metrics.performance.lcp_resource.initiator.url) AS url,
    JSON_VALUE(custom_metrics.performance.is_lcp_statically_discoverable) = 'false' AS not_discoverable
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01' AND
    is_root_page
),

requests AS (
  SELECT
    client,
    page,
    url,
    type
  FROM
    `httparchive.crawl.requests`
  WHERE
    date = '2025-07-01'
)

SELECT
  client,
  IFNULL(type, 'unknown') AS lcp_initiator_type,
  COUNTIF(not_discoverable) AS pages,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNTIF(not_discoverable) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  lcp
LEFT JOIN
  requests
USING (client, page, url)
GROUP BY
  client,
  type
ORDER BY
  pct DESC
