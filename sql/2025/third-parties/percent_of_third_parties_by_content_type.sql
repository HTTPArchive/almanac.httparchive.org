#standardSQL
# Percent of third party requests by content type.

WITH requests AS (
  SELECT
    client,
    page,
    url,
    type AS contentType
  FROM
    `httparchive.crawl.requests`
  WHERE
    date = '2025-07-01'
),

third_party AS (
  SELECT
    domain,
    category,
    COUNT(DISTINCT page) AS page_usage
  FROM
    `httparchive.almanac.third_parties` tp
  JOIN
    requests r
  ON NET.HOST(r.url) = NET.HOST(tp.domain)
  WHERE
    date = '2025-07-01' AND
    category != 'hosting'
  GROUP BY
    domain,
    category
  HAVING
    page_usage >= 50
)

SELECT
  client,
  contentType,
  COUNT(0) AS requests,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_requests,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct_requests
FROM
  requests
LEFT JOIN
  third_party
ON
  NET.HOST(requests.url) = NET.HOST(third_party.domain)
WHERE
  domain IS NOT NULL
GROUP BY
  client,
  contentType
ORDER BY
  client,
  contentType
