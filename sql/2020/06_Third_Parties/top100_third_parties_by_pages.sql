#standardSQL
# Top third party domains by number of pages broken down by client

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
    COUNT(DISTINCT page) AS total_pages
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
  canonicalDomain,
  total_pages
FROM (
  SELECT
    client,
    canonicalDomain,
    total_pages
  FROM
    base
  WHERE
    client = 'desktop'
  ORDER BY
    total_pages DESC
  LIMIT 100
) UNION ALL (
  SELECT
    client,
    canonicalDomain,
    total_pages
  FROM
    base
  WHERE
    client = 'mobile'
  ORDER BY
    total_pages DESC
  LIMIT 100
)
ORDER BY
  client,
  total_pages DESC
