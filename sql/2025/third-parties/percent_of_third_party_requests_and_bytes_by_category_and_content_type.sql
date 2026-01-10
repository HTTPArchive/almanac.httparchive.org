#standardSQL
# Percent of third party requests and bytes by category and content type.

WITH requests AS (
  SELECT
    _TABLE_SUFFIX AS client,
    pageid AS page,
    url,
    type AS contentType,
    respBodySize AS body_size
  FROM
    `httparchive.summary_requests.2025_06_01_*`
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
),

base AS (
  SELECT
    client,
    page,
    category,
    contentType,
    body_size
  FROM
    requests
  INNER JOIN
    third_party
  ON
    NET.HOST(requests.url) = NET.HOST(third_party.domain)
),

requests_per_page_and_category AS (
  SELECT
    client,
    page,
    category,
    contentType,
    SUM(SUM(body_size)) OVER (PARTITION BY page) AS total_page_size,
    SUM(body_size) AS body_size,
    SUM(COUNT(0)) OVER (PARTITION BY page) AS total_page_requests,
    COUNT(0) AS requests
  FROM
    base
  GROUP BY
    client,
    page,
    category,
    contentType
)

SELECT
  client,
  category,
  contentType,
  SUM(requests) AS requests,
  SAFE_DIVIDE(SUM(requests), SUM(SUM(requests)) OVER (PARTITION BY client, category)) AS pct_requests,
  SUM(body_size) AS body_size,
  SAFE_DIVIDE(SUM(body_size), SUM(SUM(body_size)) OVER (PARTITION BY client, category)) AS pct_body_size
FROM
  requests_per_page_and_category
GROUP BY
  client,
  category,
  contentType
ORDER BY
  client,
  category,
  contentType
