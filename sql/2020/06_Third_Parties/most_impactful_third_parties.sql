#standardSQL
# Biggest response and slowest third-parties by category

WITH requests AS (
  SELECT
    'desktop' AS client,
    req_host AS host,
    respBodySize AS body_size,
    time
  FROM
    `httparchive.summary_requests.2020_08_01_desktop`
  UNION ALL (
    SELECT
      'mobile' AS client,
      req_host AS host,
      respBodySize AS body_size,
      time
    FROM
      `httparchive.summary_requests.2020_08_01_mobile`
  )
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
    canonicalDomain,
    IFNULL(category, 'first-party') AS category,
    APPROX_QUANTILES(body_size, 1000)[OFFSET(500)] AS body_size,
    APPROX_QUANTILES(time, 1000)[OFFSET(500)] AS time
  FROM
    requests
  LEFT JOIN
    third_party
  ON
    NET.HOST(requests.host) = NET.HOST(third_party.domain)
  GROUP BY
    client,
    canonicalDomain,
    category
)

SELECT
  ranking,
  client,
  category,
  canonicalDomain,
  metric
FROM (
  SELECT
    'top10_body_size' AS ranking,
    client,
    category,
    canonicalDomain,
    body_size AS metric
  FROM base
  ORDER BY
    body_size DESC
  LIMIT 10
)
UNION ALL (
  SELECT
    'top10_time' AS ranking,
    client,
    category,
    canonicalDomain,
    time AS metric
  FROM base
  ORDER BY
    time DESC
  LIMIT 10
)
ORDER BY
  ranking,
  client,
  category,
  canonicalDomain