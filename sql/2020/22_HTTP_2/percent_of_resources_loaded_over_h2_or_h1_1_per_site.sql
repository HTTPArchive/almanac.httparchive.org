# standardSQL
# Percentage of resources loaded over HTTP/2 or HTTP/1.1 per site
SELECT
  client,
  APPROX_QUANTILES((http_1_1/num_requests) * 100, 1000)[OFFSET(500)] AS median_avg_pct_http_1_1,
  APPROX_QUANTILES((http_2/num_requests) * 100, 1000)[OFFSET(500)] AS median_avg_pct_http_2
FROM (
  SELECT 
    percentile,
    client,
    page,
    COUNT(0) AS num_requests, 
    SUM(IF(JSON_EXTRACT_SCALAR(payload, "$._protocol") ="http/0.9",1,0)) AS http_0_9, 
    SUM(IF(JSON_EXTRACT_SCALAR(payload, "$._protocol") ="http/1.0",1,0)) AS http_1_0, 
    SUM(IF(JSON_EXTRACT_SCALAR(payload, "$._protocol") ="http/1.1",1,0)) AS http_1_1,
    SUM(IF(JSON_EXTRACT_SCALAR(payload, "$._protocol") ="HTTP/2",1,0)) AS http_2,
    SUM(IF(JSON_EXTRACT_SCALAR(payload, "$._protocol") IN ("QUIC","http/2+quic/46"),1,0)) AS quic
  FROM 
    `httparchive.almanac.requests`,
    UNNEST([10, 25, 50, 75, 90]) AS percentile
  WHERE
    date='2020-08-01'
  GROUP BY
    percentile,
    client,
    page
)
GROUP BY 
  client
