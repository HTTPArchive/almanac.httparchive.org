#standardSQL
# Compressed images by third parties

WITH requests AS (
  SELECT
    _TABLE_SUFFIX AS client,
    pageid AS page,
    url,
    resp_content_encoding AS content_encoding,
    type
  FROM
    `httparchive.summary_requests.2022_06_01_*`
  WHERE
    type = 'image' AND (
      resp_content_encoding = 'gzip' OR
      resp_content_encoding = 'br'
    )
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
    date = '2022-06-01' AND
    category != 'hosting'
  GROUP BY
    domain
  HAVING
    page_usage >= 50
)

SELECT
  client,
  content_encoding,
  domain,
  num_requests,
  total,
  pct
FROM (
  SELECT
    client,
    content_encoding,
    domain,
    COUNT(0) AS num_requests,
    SUM(COUNT(0)) OVER (PARTITION BY client, type) AS total,
    COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client, type) AS pct,
    RANK() OVER (PARTITION BY client, content_encoding ORDER BY COUNT(0) DESC) AS domain_rank
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
    content_encoding,
    domain
)
WHERE
  domain_rank <= 100
ORDER BY
  client,
  content_encoding,
  num_requests DESC
