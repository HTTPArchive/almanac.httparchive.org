# standardSQL
# Percentiles of sites that load resources of HTTP/2 or above
SELECT
  client,
  percentile,
  APPROX_QUANTILES(http2_3_pct, 1000)[OFFSET(percentile * 10)] AS http2_or_above
FROM (
  SELECT
    client,
    page,
    COUNTIF(LOWER(protocol) IN ('http/2', 'http/3', 'quic', 'h3-29', 'h3-q050')) / COUNT(0) AS http2_3_pct
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
