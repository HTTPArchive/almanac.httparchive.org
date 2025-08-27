#standardSQL
# Distribution of third party requests size and time by category

WITH requests AS (
  SELECT
    _TABLE_SUFFIX AS client,
    pageid AS page,
    url,
    respBodySize AS body_size,
    time
  FROM
    `httparchive.summary_requests.2025_07_01_*`
),

third_party AS (
  SELECT
    domain,
    category,
    COUNT(DISTINCT page) AS page_usage
  FROM
    `httparchive.almanac.third_parties` tp
  JOIN
    requests r
  ON NET.HOST(r.url) = NET.HOST(tp.domain)
  WHERE
    date = '2025-07-01' AND
    category != 'hosting'
  GROUP BY
    domain,
    category
  HAVING
    page_usage >= 50
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
    NET.HOST(requests.url) = NET.HOST(third_party.domain)
)

SELECT
  client,
  category,
  percentile,
  APPROX_QUANTILES(body_size, 1000)[OFFSET(percentile * 10)] AS body_size,
  APPROX_QUANTILES(time, 1000)[OFFSET(percentile * 10)] AS time -- noqa: L010
FROM
  base,
  UNNEST(GENERATE_ARRAY(1, 100)) AS percentile
GROUP BY
  client,
  category,
  percentile
ORDER BY
  client,
  category,
  percentile
