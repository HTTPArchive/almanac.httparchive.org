#standardSQL
# Distribution of third parties by number of websites

WITH requests AS (
  SELECT
    _TABLE_SUFFIX AS client,
    pageid AS page,
    url
  FROM
    `httparchive.summary_requests.2025_06_01_*`
),

third_party AS (
  SELECT
    domain,
    canonicalDomain,
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
    canonicalDomain,
    category
  HAVING
    page_usage >= 50
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
    NET.HOST(requests.url) = NET.HOST(third_party.domain)
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
