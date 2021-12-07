#standardSQL
# Top 100 third parties by median response body size, time

WITH requests AS (
  SELECT
    _TABLE_SUFFIX AS client,
    req_host AS host,
    respBodySize AS body_size,
    time
  FROM
    `httparchive.summary_requests.2020_08_01_*`
),

third_party AS (
  SELECT
    domain,
    canonicalDomain,
    category
  FROM
    `httparchive.almanac.third_parties`
  WHERE
    date = '2020-08-01'
),

base AS (
  SELECT
    client,
    category,
    canonicalDomain,
    APPROX_QUANTILES(body_size, 1000)[OFFSET(500)] / 1024 AS median_body_size_kb,
    APPROX_QUANTILES(time, 1000)[OFFSET(500)] / 1000 AS median_time_s
  FROM
    requests
  INNER JOIN
    third_party
  ON
    NET.HOST(requests.host) = NET.HOST(third_party.domain)
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
  rank
FROM (
  SELECT
    'median_body_size_kb' AS ranking,
    client,
    category,
    canonicalDomain,
    median_body_size_kb AS metric,
    DENSE_RANK() OVER (PARTITION BY client ORDER BY median_body_size_kb DESC) AS rank
  FROM base
  UNION ALL (
    SELECT
      'median_time_s' AS ranking,
      client,
      category,
      canonicalDomain,
      median_time_s AS metric,
      DENSE_RANK() OVER (PARTITION BY client ORDER BY median_time_s DESC) AS rank
    FROM base
  )
)
WHERE
  rank <= 100
ORDER BY
  ranking,
  client,
  metric DESC
