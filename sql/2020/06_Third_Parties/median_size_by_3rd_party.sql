#standardSQL
# Percentage of third party requests, median size and type by device and category
  
WITH
  requests AS (
  SELECT
    'desktop' AS client,
    pageid,
    urlShort AS url,
    respBodySize,
    time,
  FROM
    `httparchive.summary_requests.2020_06_01_desktop`
  UNION ALL
  SELECT
    'mobile' AS client,
    pageid,
    urlShort AS url,
    respBodySize,
    time,
  FROM
    `httparchive.summary_requests.2020_06_01_mobile` ),
  third_party AS (
  SELECT
    domain,
    category
  FROM
    `lighthouse-infrastructure.third_party_web.2020_05_01`),
  base AS (
  SELECT
    client,
    pageid,
    domain,
    IFNULL(category, IF(domain IS NULL, 'first-party', 'other') ) AS category,
    SUM(respBodySize) AS respBodySize,
    SUM(time) AS time,
  FROM
    requests
  LEFT JOIN
    third_party
  ON
    NET.HOST(requests.url) = NET.HOST(third_party.domain)
  GROUP BY
    client,
    pageid,
    domain,
    category)

SELECT
  client,
  category,
  COUNT(0) AS category_requests,
  COUNT(0) OVER () AS total_requests,
  COUNT(0) / SUM(COUNT(0)) OVER () AS percentRequests,
  ANY_VALUE(median_respBodySize) AS median_respBodySize,
  ANY_VALUE(median_time) AS median_time,
FROM (
  SELECT
    client,
    category,
    PERCENTILE_CONT(respBodySize, 0.5) OVER(PARTITION BY client, category) AS median_respBodySize,
    PERCENTILE_CONT(time, 0.5) OVER(PARTITION BY client, category) AS median_time,
  FROM
    base)
GROUP BY
  client,
  category