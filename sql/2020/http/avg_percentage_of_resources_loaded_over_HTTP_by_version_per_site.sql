# standardSQL
# Average percentage of resources loaded over HTTP .9, 1, 1.1, 2, and QUIC per site
SELECT
  client,
  AVG(http09_pct) AS http09_pct,
  AVG(http10_pct) AS http10_pct,
  AVG(http11_pct) AS http11_pct,
  AVG(http2_pct) AS http2_pct,
  AVG(quic_pct) AS quic_pct,
  AVG(http2quic46_pct) AS http2quic46_pct,
  AVG(other_pct) AS other_pct,
  AVG(null_pct) AS null_pct
FROM (
  SELECT
    client,
    page,
    COUNTIF(JSON_EXTRACT_SCALAR(payload, '$._protocol') = 'http/0.9') / COUNT(0) AS http09_pct,
    COUNTIF(JSON_EXTRACT_SCALAR(payload, '$._protocol') = 'http/1.0') / COUNT(0) AS http10_pct,
    COUNTIF(JSON_EXTRACT_SCALAR(payload, '$._protocol') = 'http/1.1') / COUNT(0) AS http11_pct,
    COUNTIF(JSON_EXTRACT_SCALAR(payload, '$._protocol') = 'HTTP/2') / COUNT(0) AS http2_pct,
    COUNTIF(JSON_EXTRACT_SCALAR(payload, '$._protocol') = 'QUIC') / COUNT(0) AS quic_pct,
    COUNTIF(JSON_EXTRACT_SCALAR(payload, '$._protocol') = 'http/2+quic/46') / COUNT(0) AS http2quic46_pct,
    COUNTIF(JSON_EXTRACT_SCALAR(payload, '$._protocol') NOT IN ('http/0.9', 'http/1.0', 'http/1.1', 'HTTP/2', 'QUIC', 'http/2+quic/46')) / COUNT(0) AS other_pct,
    COUNTIF(JSON_EXTRACT_SCALAR(payload, '$._protocol') IS NULL) / COUNT(0) AS null_pct
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2020-08-01'
  GROUP BY
    client,
    page)
GROUP BY
  client
ORDER BY
  client
