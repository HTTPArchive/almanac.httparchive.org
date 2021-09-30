#standardSQL
# Top 100 third parties by number of websites

WITH requests AS (
  SELECT
    _TABLE_SUFFIX AS client,
    pageid AS page,
    req_host AS host
  FROM
    `httparchive.summary_requests.2021_07_01_*`
),

third_party AS (
  SELECT
    domain,
    canonicalDomain
  FROM
    `httparchive.almanac.third_parties`
  WHERE
    date = '2021-07-01'
),

base AS (
  SELECT
    client,
    canonicalDomain,
    COUNT(DISTINCT page) AS total_pages,
    COUNT(DISTINCT page) / COUNT(0) OVER () AS pct_pages
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
  canonicalDomain,
  total_pages,
  pct_pages
FROM (
  SELECT
    client,
    canonicalDomain,
    total_pages,
    pct_pages,
    DENSE_RANK() OVER (PARTITION BY client ORDER BY total_pages DESC) AS rank
  FROM
    base
)
WHERE
  rank <= 100
ORDER BY
  total_pages DESC
