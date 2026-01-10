#standardSQL
# Compressed images (excluding SVG) by third parties

WITH requests AS (
  SELECT
    _TABLE_SUFFIX AS client,
    pageid AS page,
    url,
    resp_content_encoding AS content_encoding,
    type,
    respBodySize AS size
  FROM
    `httparchive.summary_requests.2025_06_01_*`
  WHERE
    type = 'image' AND (
      resp_content_encoding = 'gzip' OR
      resp_content_encoding = 'br'
    ) AND NOT (
      resp_content_type LIKE 'image/svg%' OR
      ENDS_WITH(url, '.svg')
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
    date = '2025-07-01' AND
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
  size,
  SUM(size) OVER (PARTITION BY client) AS total_size,
  size / SUM(size) OVER (PARTITION BY client) AS pct_size,
  num_requests,
  total_requests,
  pct_requests
FROM (
  SELECT
    client,
    content_encoding,
    domain,
    COUNT(0) AS num_requests,
    SUM(size) AS size,
    SUM(COUNT(0)) OVER (PARTITION BY client) AS total_requests,
    COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct_requests,
    RANK() OVER (PARTITION BY client, type, content_encoding ORDER BY COUNT(0) DESC) AS domain_rank
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
  size DESC
