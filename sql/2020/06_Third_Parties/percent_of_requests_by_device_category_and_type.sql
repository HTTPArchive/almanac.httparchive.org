#standardSQL
# Percent of pages with third party requests by device

WITH requests AS (
  SELECT
    'desktop' AS client,
    pageid as page,
    req_host as host,
    type AS contentType
  FROM
    `httparchive.summary_requests.2020_08_01_desktop`
  UNION ALL (
    SELECT
      'mobile' AS client,
      pageid as page,
      req_host as host,
      type AS contentType
    FROM
      `httparchive.summary_requests.2020_08_01_mobile`
  )
),
thirdParty AS (
  SELECT
    domain,
    category
  FROM
    `httparchive.almanac.third_parties`
  WHERE
    date = '2020-08-01'
)

SELECT
  client,
  IFNULL(category, IF(domain IS NULL, 'first-party', 'other') ) AS category,
  contentType,
  COUNT(0) AS requests,
  COUNT(0) / SUM(COUNT(0)) OVER () AS pct_requests
FROM
  requests
  LEFT JOIN thirdParty
  ON NET.HOST(requests.host) = NET.HOST(thirdParty.domain)
GROUP BY
  client,
  category,
  contentType
