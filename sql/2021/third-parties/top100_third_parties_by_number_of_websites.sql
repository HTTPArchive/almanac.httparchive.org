#standardSQL
# Top 100 third parties by number of websites

WITH requests AS (
  SELECT
    _TABLE_SUFFIX AS client,
    pageid AS page,
    url
  FROM
    `httparchive.summary_requests.2021_07_01_*`
),

totals AS (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_pages
  FROM
    `httparchive.summary_pages.2021_07_01_*`
  GROUP BY _TABLE_SUFFIX
),

third_party AS (
  SELECT
    domain,
    canonicalDomain
  FROM
    `httparchive.almanac.third_parties`
  WHERE
    date = '2021-07-01' AND
    category != 'hosting'
)

SELECT
  client,
  canonicalDomain,
  COUNT(DISTINCT page) AS pages,
  total_pages,
  COUNT(DISTINCT page) / total_pages AS pct_pages,
  DENSE_RANK() OVER (PARTITION BY client ORDER BY COUNT(DISTINCT page) DESC) AS sorted_order
FROM
  requests
LEFT JOIN
  third_party
ON
  NET.HOST(requests.url) = NET.HOST(third_party.domain)
JOIN
  totals
USING (client)
WHERE
  canonicalDomain IS NOT NULL
GROUP BY
  client,
  total_pages,
  canonicalDomain
QUALIFY
  sorted_order <= 100
ORDER BY
  pct_pages DESC,
  client
