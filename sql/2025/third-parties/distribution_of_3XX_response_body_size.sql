#standardSQL
# Distribution of response body size by redirected third parties
# HTTP status codes documentation: https://developer.mozilla.org/docs/Web/HTTP/Status

WITH requests AS (
  SELECT
    _TABLE_SUFFIX AS client,
    pageid AS page,
    url,
    status,
    respBodySize AS body_size
  FROM
    `httparchive.summary_requests.2025_06_01_*`
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
    domain,
    IF(status BETWEEN 300 AND 399, 1, 0) AS redirected,
    body_size
  FROM
    requests
  LEFT JOIN
    third_party
  ON
    NET.HOST(requests.url) = NET.HOST(third_party.domain)
)

SELECT
  client,
  percentile,
  APPROX_QUANTILES(body_size, 1000)[OFFSET(percentile * 10)] AS approx_redirect_body_size
FROM
  base,
  UNNEST(GENERATE_ARRAY(1, 100)) AS percentile
WHERE
  redirected = 1
GROUP BY
  client,
  percentile
ORDER BY
  client,
  percentile
