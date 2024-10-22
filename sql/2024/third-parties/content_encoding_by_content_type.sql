#standardSQL
#content-encoding by third parties by content-type

WITH requests AS (
  SELECT
    _TABLE_SUFFIX AS client,
    pageid AS page,
    url,
    resp_content_encoding AS content_encoding,
    type
  FROM
    `httparchive.summary_requests.2024_06_01_*`
),

third_party AS (
  SELECT
    NET.HOST(domain) AS domain,
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
    domain
  HAVING
    page_usage >= 50
)

SELECT
  client,
  type,
  content_encoding,
  COUNT(0) AS num_requests,
  SUM(COUNT(0)) OVER (PARTITION BY client, type) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client, type) AS pct
FROM
  requests
LEFT JOIN
  third_party
ON
  NET.HOST(requests.url) = NET.HOST(third_party.domain)
WHERE
  domain IS NOT NULL
GROUP BY
  client,
  type,
  content_encoding
ORDER BY
  client,
  type,
  num_requests DESC
