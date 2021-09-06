# standardSQL
# Average percentage of resources loaded over HTTP 0.9, 1.0, 1.1, 2, and QUIC per site
SELECT
  client,
  AVG(http09_pct) AS http09_pct,
  AVG(http10_pct) AS http10_pct,
  AVG(http11_pct) AS http11_pct,
  AVG(http2_pct) AS http2_pct,
  AVG(http3_pct) AS http3_pct,
  AVG(other_pct) AS other_pct,
  AVG(null_pct) AS null_pct
FROM (
  SELECT
    client,
    page,
    COUNTIF(LOWER(protocol) = 'http/0.9') / COUNT(0) AS http09_pct,
    COUNTIF(LOWER(protocol) = 'http/1.0') / COUNT(0) AS http10_pct,
    COUNTIF(LOWER(protocol) = 'http/1.1') / COUNT(0) AS http11_pct,
    COUNTIF(LOWER(protocol) = 'http/2') / COUNT(0) AS http2_pct,
    COUNTIF(LOWER(protocol) IN ('http/3', 'h3-29', 'h3-q050', 'quic')) / COUNT(0) AS http3_pct,
    COUNTIF(LOWER(protocol) NOT IN ('http/0.9', 'http/1.0', 'http/1.1', 'http/2', 'http/3', 'quic', 'h3-29', 'h3-q050')) / COUNT(0) AS other_pct,
    COUNTIF(protocol IS NULL) / COUNT(0) AS null_pct
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2021-07-01'
  GROUP BY
    client,
    page)
GROUP BY
  client
ORDER BY
  client
