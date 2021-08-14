# standardSQL
# Percentiles of sites that load resources of HTTP/2 or above
SELECT
  client,
  percentile,
  APPROX_QUANTILES(ROUND(http2_3_pct, 2), 1000)[OFFSET(percentile * 10)] AS http2_or_above
FROM (
  SELECT
    client,
    page,
    COUNTIF(protocol IN ('HTTP/2', 'HTTP/3', 'QUIC', 'h3-29', 'h3-Q050')) / COUNT(0) AS http2_3_pct
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2021-07-01'
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
