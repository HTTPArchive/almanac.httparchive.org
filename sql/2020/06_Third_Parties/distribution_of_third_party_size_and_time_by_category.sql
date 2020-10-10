#standardSQL
# Percentage of third party requests, size and time distribution by category

WITH requests AS (
  SELECT
    'mobile' AS client,
    pageid AS page,
    req_host AS host,
    respBodySize AS body_size,
    respHeadersSize AS header_size,
    time
  FROM
    `httparchive.summary_requests.2020_08_01_mobile`
),
third_party AS (
  SELECT
    domain,
    category
  FROM
    `httparchive.almanac.third_parties`
  WHERE
    date = '2020-08-01'
),
base AS (
  SELECT
    page,
    host,
    IFNULL(category, IF(domain IS NULL, 'first-party', 'other') ) AS category,
    body_size,
    header_size,
    time
  FROM
    requests
  LEFT JOIN
    third_party
  ON
    NET.HOST(requests.host) = NET.HOST(third_party.domain)
)

SELECT
  category,
  percentile,
  COUNT(category) AS category_requests,
  COUNT(category) / SUM(COUNT(0)) OVER () AS pct_category_request,
  APPROX_QUANTILES(body_size, 1000)[OFFSET(percentile * 10)] AS body_size,
  APPROX_QUANTILES(header_size, 1000)[OFFSET(percentile * 10)] AS header_size,
  APPROX_QUANTILES(time, 1000)[OFFSET(percentile * 10)] AS time
FROM base,
UNNEST([0, 10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  category,
  percentile