#standardSQL
# Distribution of third party requests size and time by category and content type

WITH requests AS (
  SELECT
    'desktop' AS client,
    req_host AS host,
    type AS contentType,
    respBodySize AS body_size,
    respHeadersSize AS header_size,
    time
  FROM
    `httparchive.summary_requests.2020_08_01_desktop`
  UNION ALL (
    SELECT
      'mobile' AS client,
      req_host AS host,
      type AS contentType,
      respBodySize AS body_size,
      respHeadersSize AS header_size,
      time
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
    IFNULL(category, 'first-party') AS category,
    contentType,
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
  contentType,
  percentile,
  APPROX_QUANTILES(body_size, 1000)[OFFSET(percentile)] AS body_size,
  APPROX_QUANTILES(header_size, 1000)[OFFSET(percentile)] AS header_size,
  APPROX_QUANTILES(time, 1000)[OFFSET(percentile)] AS time
FROM
  base,
UNNEST(GENERATE_ARRAY(0, 1000, 1)) AS percentile
GROUP BY
  category,
  contentType,
  percentile
ORDER BY
  category,
  contentType,
  percentile