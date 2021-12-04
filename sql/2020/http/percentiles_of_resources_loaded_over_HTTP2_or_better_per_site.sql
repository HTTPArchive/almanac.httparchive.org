# standardSQL
# Percentiles of sites that load resources of HTTP/2 or above
SELECT
  client,
  percentile,
  APPROX_QUANTILES(ROUND(http2_pct, 2), 1000)[OFFSET(percentile * 10)] AS http2_or_above
FROM (
  SELECT
    client,
    page,
    COUNTIF(JSON_EXTRACT_SCALAR(payload, '$._protocol') IN ('HTTP/2', 'QUIC', 'http/2+quic/46')) / COUNT(0) AS http2_pct
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2020-08-01'
  GROUP BY
    client,
    page),
  UNNEST([5, 6, 7, 8, 9, 10, 25, 50, 75, 90, 95, 100]) AS percentile
GROUP BY
  client,
  percentile
ORDER BY
  client,
  percentile
