#standardSQL
# Percent of pages with third party requests by client

WITH requests AS (
  SELECT
    'desktop' AS client,
    pageid as page,
    req_host as host
  FROM
    `httparchive.summary_requests.2020_08_01_desktop`
  UNION ALL (
    SELECT
      'mobile' AS client,
      pageid as page,
      req_host as host
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
)

SELECT
  client,
  COUNT(DISTINCT page) AS total_pages,
  COUNT(DISTINCT IF(domain IS NOT NULL, page, NULL)) / COUNT(DISTINCT page) AS pct_pages_with_third_party
FROM
  requests
  LEFT JOIN third_party
  ON NET.HOST(requests.host) = NET.HOST(third_party.domain)
GROUP BY
  client
