#standardSQL
# Distribution of websites by number of third party

-- updated for crawl.requests
WITH requests AS (
  SELECT
    client,
    page,
    url
  FROM
    `httparchive.crawl.requests`
  WHERE
    date = '2025-07-01'
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
    page,
    COUNT(domain) AS third_parties_per_page
  FROM
    requests
  LEFT JOIN
    third_party
  ON
    NET.HOST(requests.url) = NET.HOST(third_party.domain)
  GROUP BY
    client,
    page
)

SELECT
  client,
  percentile,
  APPROX_QUANTILES(third_parties_per_page, 1000)[OFFSET(percentile * 10)] AS approx_third_parties_per_page
FROM
  base,
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  client,
  percentile
ORDER BY
  client,
  percentile
