#standardSQL
#content-encoding by third parties by content-type

WITH requests AS (
  SELECT
    _TABLE_SUFFIX AS client,
    pageid AS page,
    url,
    resp_content_encoding AS content_encoding,
    CASE
      WHEN resp_content_type LIKE '%html%' THEN 'html'
      WHEN resp_content_type LIKE '%xml%' THEN 'xml'
      WHEN resp_content_type LIKE '%plain%' THEN 'plain'
      WHEN resp_content_type LIKE '%video%' THEN 'video'
      WHEN resp_content_type LIKE '%audio%' THEN 'audio'
      WHEN resp_content_type LIKE '%image%' THEN 'image'
      WHEN resp_content_type LIKE '%font%' THEN 'font'
      WHEN resp_content_type LIKE '%css%' THEN 'css'
      WHEN resp_content_type LIKE '%javascript%' THEN 'javascript'
      WHEN resp_content_type LIKE '%json%' THEN 'json'
      ELSE 'other'
    END AS content_type
  FROM
    `httparchive.summary_requests.2022_06_01_*`
),

third_party AS (
  SELECT
    domain,
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
  content_type,
  content_encoding,
  COUNT(0) AS num_requests,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
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
  content_type,
  content_encoding
ORDER BY
  client,
  content_type,
  num_requests DESC