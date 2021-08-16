#standardSQL
# Distribution of third party requests size and time by category

WITH requests AS (
  SELECT
    _TABLE_SUFFIX AS client,
    req_host AS host,
    respBodySize AS body_size,
    time
  FROM
    `httparchive.summary_requests.2020_08_01_*`
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
    category,
    body_size,
    time
  FROM
    requests
  INNER JOIN
    third_party
  ON
    NET.HOST(requests.host) = NET.HOST(third_party.domain)
)

SELECT
  category,
  percentile,
  APPROX_QUANTILES(body_size, 1000)[OFFSET(percentile * 10)] AS body_size,
  APPROX_QUANTILES(time, 1000)[OFFSET(percentile * 10)] AS time
FROM
  base,
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  category,
  percentile
ORDER BY
  category,
  percentile
