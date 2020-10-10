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
    COUNTIF(domain IS NOT NULL) AS thirdparty_requests
  FROM (
    SELECT
      requests.client,
      requests.page,
      thirdParty.domain
    FROM
      requests
      LEFT JOIN thirdParty ON NET.HOST(requests.host) = NET.HOST(thirdParty.domain)
    GROUP BY
      client,
      page,
      domain
  )
  GROUP BY
    client,
    page
)

SELECT
  client,
  COUNT(page) AS pages_total,
  COUNTIF(thirdparty_requests > 0) AS pages_with_thirdparty_requests,
  COUNTIF(thirdparty_requests > 0) / COUNT(page) AS pct_pages_with_thirdparty_requests
FROM base
GROUP BY
  client