#standardSQL
# Distribution of pages per third party

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
    domain,
    canonicalDomain
  FROM
    `httparchive.almanac.third_parties`
  WHERE
    date = '2020-08-01'
),
base AS (
  SELECT
    client,
    canonicalDomain,
    COUNT(DISTINCT page) AS pages_per_third_party
  FROM
    requests
  LEFT JOIN
    third_party
  ON
    NET.HOST(requests.host) = NET.HOST(third_party.domain)
  WHERE
    canonicalDomain IS NOT NULL
  GROUP BY
    client,
    canonicalDomain
)

SELECT
  client,
  percentile,
  APPROX_QUANTILES(pages_per_third_party, 1000)[OFFSET(percentile)] AS approx_pages_per_third_party
FROM
  base,
UNNEST(GENERATE_ARRAY(0, 1000, 1)) AS percentile
GROUP BY
  client,
  percentile