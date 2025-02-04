# standardSQL
# Median percentage of resources loaded over HTTP 0.9, 1.0, 1.1, 2+ per site
SELECT
  client,
  APPROX_QUANTILES(http09_pct, 1000)[OFFSET(50 * 10)] AS http09_pct,
  APPROX_QUANTILES(http10_pct, 1000)[OFFSET(50 * 10)] AS http10_pct,
  APPROX_QUANTILES(http11_pct, 1000)[OFFSET(50 * 10)] AS http11_pct,
  APPROX_QUANTILES(http2_3_pct, 1000)[OFFSET(50 * 10)] AS http2_3_pct,
  APPROX_QUANTILES(other_pct, 1000)[OFFSET(50 * 10)] AS other_pct,
  APPROX_QUANTILES(null_pct, 1000)[OFFSET(50 * 10)] AS null_pct
FROM (
  SELECT
    client,
    page,
    COUNTIF(LOWER(protocol) = 'http/0.9') / COUNT(0) AS http09_pct,
    COUNTIF(LOWER(protocol) = 'http/1.0') / COUNT(0) AS http10_pct,
    COUNTIF(LOWER(protocol) = 'http/1.1') / COUNT(0) AS http11_pct,
    COUNTIF(LOWER(protocol) = 'http/2' OR LOWER(protocol) IN ('http/3', 'h3-29', 'h3-q050', 'quic')) / COUNT(0) AS http2_3_pct,
    COUNTIF(LOWER(protocol) NOT IN ('http/0.9', 'http/1.0', 'http/1.1', 'http/2', 'http/3', 'quic', 'h3-29', 'h3-q050')) / COUNT(0) AS other_pct,
    COUNTIF(protocol IS NULL) / COUNT(0) AS null_pct
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2021-07-01'
  GROUP BY
    client,
    page
)
GROUP BY
  client
ORDER BY
  client
