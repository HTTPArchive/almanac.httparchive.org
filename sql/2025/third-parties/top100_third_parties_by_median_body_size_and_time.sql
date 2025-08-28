#standardSQL
# Top 100 third parties by median response body size, time

WITH requests AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    pageid AS page,
    respBodySize AS body_size,
    time
  FROM
    `httparchive.summary_requests.2025_06_01_*`
),

third_party AS (
  SELECT
    domain,
    category,
    canonicalDomain,
    COUNT(DISTINCT page) AS page_usage
  FROM
    `httparchive.almanac.third_parties` tp
  JOIN
    requests r
  ON NET.HOST(r.url) = NET.HOST(tp.domain)
  WHERE
    date = '2025-06-01' AND
    category != 'hosting'
  GROUP BY
    domain,
    canonicalDomain,
    category
  HAVING
    page_usage >= 50
),

base AS (
  SELECT
    client,
    category,
    canonicalDomain,
    APPROX_QUANTILES(body_size, 1000)[OFFSET(500)] / 1024 AS median_body_size_kb,
    APPROX_QUANTILES(time, 1000)[OFFSET(500)] / 1000 AS median_time_s -- noqa: L010
  FROM
    requests
  INNER JOIN
    third_party
  ON
    NET.HOST(requests.url) = NET.HOST(third_party.domain)
  GROUP BY
    client,
    category,
    canonicalDomain
)

SELECT
  ranking,
  client,
  category,
  canonicalDomain,
  metric,
  sorted_order
FROM (
  SELECT
    'median_body_size_kb' AS ranking,
    client,
    category,
    canonicalDomain,
    median_body_size_kb AS metric,
    DENSE_RANK() OVER (PARTITION BY client ORDER BY median_body_size_kb DESC) AS sorted_order
  FROM base
  UNION ALL
  SELECT
    'median_time_s' AS ranking,
    client,
    category,
    canonicalDomain,
    median_time_s AS metric,
    DENSE_RANK() OVER (PARTITION BY client ORDER BY median_time_s DESC) AS sorted_order
  FROM base
)
WHERE
  sorted_order <= 100
ORDER BY
  ranking,
  client,
  metric DESC
