#standardSQL
# Distribution of third party requests by origin

WITH requests AS (
  SELECT
    'desktop' AS client,
    pageid AS page,
    req_host AS host
  FROM
    `httparchive.summary_requests.2020_08_01_desktop`
  UNION ALL (
    SELECT
      'mobile' AS client,
      pageid AS page,
      req_host AS host
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
    page,
    COUNT(domain) AS third_party_requests_per_page
  FROM
    requests
  LEFT JOIN
    third_party
  ON
    NET.HOST(requests.host) = NET.HOST(third_party.domain)
  GROUP BY
    client,
    page
)

SELECT
  client,
  percentile,
  APPROX_QUANTILES(third_party_requests_per_page, 1000)[OFFSET(percentile * 10)] AS approx_third_party_requests_per_page
FROM
  base,
UNNEST([0, 10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  client,
  percentile