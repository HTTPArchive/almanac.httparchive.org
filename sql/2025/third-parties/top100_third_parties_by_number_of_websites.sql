#standardSQL
# Top 100 third parties by number of websites

WITH requests AS (
  SELECT
    _TABLE_SUFFIX AS client,
    pageid AS page,
    url
  FROM
    `httparchive.summary_requests.2024_06_01_*`
),

totals AS (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(DISTINCT pageid) AS total_pages,
    COUNT(0) AS total_requests
  FROM
    `httparchive.summary_requests.2024_06_01_*`
  GROUP BY
    _TABLE_SUFFIX
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
    date = '2024-06-01' AND
    category != 'hosting'
  GROUP BY
    domain,
    canonicalDomain,
    category
  HAVING
    page_usage >= 50
)

SELECT
  client,
  canonicalDomain,
  COUNT(DISTINCT page) AS pages,
  total_pages,
  COUNT(DISTINCT page) / total_pages AS pct_pages,
  COUNT(0) AS requests,
  total_requests,
  COUNT(0) / total_requests AS pct_requests,
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
  total_requests,
  canonicalDomain
QUALIFY
  sorted_order <= 100
ORDER BY
  pct_pages DESC,
  client
