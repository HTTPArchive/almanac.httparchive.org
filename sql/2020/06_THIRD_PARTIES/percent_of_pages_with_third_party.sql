#standardSQL
# Percent of pages that include at least one third party resource.

WITH
  requests AS (
  SELECT
    'desktop' AS client,
    page,
    url
  FROM
    `httparchive.almanac.requests_desktop_1k`
  UNION ALL
  SELECT
    'mobile' AS client,
    page,
    url
  FROM
    `httparchive.almanac.requests_mobile_1k` ),

  thirdParty AS (
  SELECT
    domain
  FROM
    `lighthouse-infrastructure.third_party_web.2020_05_01`)

SELECT
  client,
  COUNT(0) AS numberOfPages,
  COUNTIF(numberOfThirdPartyRequests > 0) AS numberOfPagesWithThirdParty,
  ROUND(COUNTIF(numberOfThirdPartyRequests > 0) * 100 / COUNT(0), 2) AS percentOfPagesWithThirdParty
FROM (
  SELECT
    client,
    page,
    COUNTIF(domain IS NOT NULL) AS numberOfThirdPartyRequests
  FROM (
    SELECT
      requests.client,
      requests.page,
      thirdParty.domain
    FROM
      requests
    LEFT JOIN
      thirdParty
    ON
      NET.HOST(requests.url) = NET.HOST(thirdParty.domain)
    GROUP BY
      client,
      page,
      domain)
  GROUP BY
    client,
    page )
GROUP BY
  client