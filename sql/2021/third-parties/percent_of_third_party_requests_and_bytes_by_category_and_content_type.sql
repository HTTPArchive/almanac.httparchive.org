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
    `httparchive.summary_requests.2021_07_01_*`
),

third_party AS (
  SELECT
    category,
    domain
  FROM
    `httparchive.almanac.third_parties`
  WHERE
    date = '2021-07-01' AND
    category != 'hosting'
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
  AVG(requests) AS avg_requests_per_page,
  SAFE_DIVIDE(SUM(requests), SUM(total_page_requests)) AS avg_pct_requests_per_page,
  AVG(body_size) AS avg_body_size_per_page,
  SAFE_DIVIDE(SUM(body_size), SUM(total_page_size)) AS avg_pct_body_size_per_page
FROM requests_per_page_and_category
GROUP BY
  client,
  category,
  contentType
ORDER BY
  client,
  category,
  contentType
