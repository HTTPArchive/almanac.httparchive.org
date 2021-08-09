# standardSQL
# HTTP/2 3rd Party by Types
SELECT
  percentile,
  client,
  category,
  ROUND(APPROX_QUANTILES(http2_pct, 1000)[OFFSET(percentile * 10)], 2) AS http2_pct
FROM (
  SELECT
    client,
    page,
    category,
    COUNTIF(http_version IN ('HTTP/2', 'QUIC', 'http/2+quic/46')) / COUNT(0) AS http2_pct
FROM (
  SELECT
    client,
    page,
    url,
    category,
    JSON_EXTRACT_SCALAR(payload, '$._protocol') AS http_version
FROM
  `httparchive.almanac.requests` r,
  `httparchive.almanac.third_parties` tp
WHERE
  r.date = '2020-08-01' AND
  tp.date = '2020-08-01' AND
  NET.HOST(url) = domain)
GROUP BY
  client,
  page,
  category),
UNNEST([5, 10, 20, 30, 40, 50, 60, 70, 80, 90, 95, 100]) AS percentile
GROUP BY
  percentile,
  client,
  category
ORDER BY
  percentile,
  client,
  category
