#standardSQL
# Percent of pages with third party by device

WITH
  requests AS (
  SELECT
    'desktop' AS client,
    page,
    url
  FROM
    `httparchive.requests.2020_06_01_desktop`
  UNION ALL
  SELECT
    'mobile' AS client,
    page,
    url
  FROM
    `httparchive.requests.2020_06_01_mobile` ),
  third_party AS (
  SELECT
    domain
  FROM
    `lighthouse-infrastructure.third_party_web.2020_05_01`),
  base AS (
  SELECT
    requests.client,
    requests.page,
    third_party.domain
  FROM
    requests
  LEFT JOIN
    third_party
  ON
    NET.HOST(requests.url) = NET.HOST(third_party.domain)
  GROUP BY
    client,
    page,
    domain)

SELECT
  client,
  COUNT(0) AS total_pages,
  COUNTIF(third_party > 0) AS pages_third_party,
  COUNTIF(third_party > 0) / COUNT(0) AS pct_pages_third_party
FROM (
  SELECT
    client,
    page,
    COUNTIF(domain IS NOT NULL) AS third_party
  FROM
    base
  GROUP BY
    client,
    page )
GROUP BY
  client