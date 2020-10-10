#standardSQL
# Percentage of total bytes that are from third party requests broken down by third party category by resource type.

WITH requests AS (
  SELECT
    'desktop' AS client,
    pageid AS page,
    req_host AS host,
    type AS contentType,
    respBodySize AS body_size
  FROM
    `httparchive.summary_requests.2020_08_01_desktop`
  UNION ALL (
    SELECT
      'mobile' AS client,
      pageid AS page,
      req_host AS host,
      type AS contentType,
      respBodySize AS body_size
    FROM
      `httparchive.summary_requests.2020_08_01_mobile`
  )
),
third_party AS (
  SELECT
    category,
    domain
  FROM
    `httparchive.almanac.third_parties`
  WHERE
    date = '2020-08-01'
),
base AS (
  SELECT
    client,
    page,
    IFNULL(category, 'first-party') AS category,
    contentType,
    body_size
  FROM
    requests
  LEFT JOIN
    third_party
  ON
    NET.HOST(requests.host) = NET.HOST(third_party.domain)
)

SELECT
  client,
  category,
  contentType,
  AVG(total_body_size) AS avg_total_body_size,
  AVG(SAFE_DIVIDE(total_body_size, total_page_size)) AS avg_pct_body_size
FROM (
  SELECT
    client,
    page,
    category,
    contentType,
    SUM(SUM(body_size)) OVER (PARTITION BY page) AS total_page_size,
    SUM(body_size) AS total_body_size,
    SAFE_DIVIDE(SUM(body_size), SUM(SUM(body_size)) OVER (PARTITION BY page)) AS pct_body_size
  FROM
    base
  GROUP BY
    client,
    page,
    category,
    contentType
)
GROUP BY
    client,
    category,
    contentType
ORDER BY
  client,
  category,
  contentType
