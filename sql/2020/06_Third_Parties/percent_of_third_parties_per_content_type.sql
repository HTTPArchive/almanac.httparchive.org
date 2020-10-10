#standardSQL
# Percent of third party requests per content type.

WITH requests AS (
  SELECT
    'desktop' AS client,
    req_host AS host,
    type AS contentType
  FROM
    `httparchive.summary_requests.2020_08_01_desktop`
  UNION ALL (
    SELECT
      'mobile' AS client,
      req_host AS host,
      type AS contentType
    FROM
      `httparchive.summary_requests.2020_08_01_mobile`
  )
),
third_party AS (
  SELECT
    domain
  FROM
    `httparchive.almanac.third_parties`
  WHERE
    date = '2020-08-01'
),
base AS (
  SELECT
    client,
    contentType
  FROM
    requests
  LEFT JOIN
    third_party
  ON
    NET.HOST(requests.host) = NET.HOST(third_party.domain)
  WHERE
    domain IS NOT NULL
)

SELECT
  client,
  contentType,
  COUNT(0) / COUNT(0) OVER (PARTITION BY client) AS pct_third_party
FROM
  base
GROUP BY
  client,
  contentType