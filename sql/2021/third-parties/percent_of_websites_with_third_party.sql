#standardSQL
# Percent of websites with third parties

WITH requests AS (
  SELECT
    _TABLE_SUFFIX AS client,
    pageid AS page,
    url
  FROM
    `httparchive.summary_requests.2021_07_01_*`
),

third_party AS (
  SELECT
    domain
  FROM
    `httparchive.almanac.third_parties`
  WHERE
    date = '2021-07-01' AND
    category != 'hosting'
)

SELECT
  client,
  COUNT(DISTINCT IF(domain IS NOT NULL, page, NULL)) AS pages_with_third_party,
  COUNT(DISTINCT page) AS total_pages,
  COUNT(DISTINCT IF(domain IS NOT NULL, page, NULL)) / COUNT(DISTINCT page) AS pct_pages_with_third_party
FROM
  requests
LEFT JOIN third_party
ON NET.HOST(requests.url) = NET.HOST(third_party.domain)
GROUP BY
  client
