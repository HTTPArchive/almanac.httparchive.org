#standardSQL
# Top 100 third parties by number of websites

WITH requests AS (
  SELECT
    pageid AS page,
    req_host AS host
  FROM
    `httparchive.summary_requests.2020_08_01_mobile`
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
    canonicalDomain,
    COUNT(DISTINCT page) AS total_pages,
    COUNT(DISTINCT page) / COUNT(DISTINCT page) OVER (PARTITION BY 0) AS pct_pages
  FROM
    requests
  LEFT JOIN
    third_party
  ON
    NET.HOST(requests.host) = NET.HOST(third_party.domain)
  WHERE
    canonicalDomain IS NOT NULL
  GROUP BY
    canonicalDomain
)


SELECT
  canonicalDomain,
  total_pages,
  pct_pages
FROM (
  SELECT
    canonicalDomain,
    total_pages,
    pct_pages,
    DENSE_RANK() OVER(PARTITION BY client ORDER BY total_pages DESC) AS rank
  FROM
    base
)
WHERE
  rank <= 100
ORDER BY
  total_pages DESC
