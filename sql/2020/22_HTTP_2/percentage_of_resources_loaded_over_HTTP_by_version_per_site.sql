# standardSQL
# Percentage of resources loaded over HTTP by version per site
SELECT
  percentile,
  client,
  APPROX_QUANTILES(http_0_9, 1000)[OFFSET(percentile * 10)] AS pct_http_0_9,
  APPROX_QUANTILES(http_1_0, 1000)[OFFSET(percentile * 10)] AS pct_http_1_0,
  APPROX_QUANTILES(http_1_1, 1000)[OFFSET(percentile * 10)] AS pct_http_1_1,
  APPROX_QUANTILES(http_2, 1000)[OFFSET(percentile * 10)] AS pct_http_2,
  APPROX_QUANTILES(quic, 1000)[OFFSET(percentile * 10)] AS pct_quic
FROM (
  SELECT
    client,
    COUNTIF(JSON_EXTRACT_SCALAR(payload, "$._protocol") = "http/0.9") / COUNT(0) AS http_0_9, 
    COUNTIF(JSON_EXTRACT_SCALAR(payload, "$._protocol") = "http/1.0") / COUNT(0) AS http_1_0, 
    COUNTIF(JSON_EXTRACT_SCALAR(payload, "$._protocol") = "http/1.1") / COUNT(0) AS http_1_1,
    COUNTIF(JSON_EXTRACT_SCALAR(payload, "$._protocol") = "HTTP/2") / COUNT(0) AS http_2,
    COUNTIF(REGEXP_CONTAINS(JSON_EXTRACT_SCALAR(payload, "$._protocol"), r"(?i)(quic|^h3|^http/3)")) AS quic
  FROM 
    `httparchive.almanac.requests`
  WHERE
    date = '2020-08-01'
  GROUP BY
    client,
    page),           
    UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
