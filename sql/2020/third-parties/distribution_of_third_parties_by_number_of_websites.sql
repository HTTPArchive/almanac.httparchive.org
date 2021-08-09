#standardSQL
# Distribution of third parties by number of websites

WITH requests AS (
  SELECT
    _TABLE_SUFFIX AS client,
    pageid AS page,
    req_host AS host
  FROM
    `httparchive.summary_requests.2020_08_01_*`
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
  APPROX_QUANTILES(pages_per_third_party, 1000)[OFFSET(percentile * 10)] AS approx_pages_per_third_party
FROM
  base,
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  client,
  percentile
ORDER BY
  client,
  percentile
