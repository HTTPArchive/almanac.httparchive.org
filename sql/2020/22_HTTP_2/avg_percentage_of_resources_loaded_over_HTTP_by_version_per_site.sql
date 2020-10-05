# standardSQL
# Average percentage of resources loaded over HTTP .9, 1, 1.1, 2, and QUIC per site
SELECT
  client,
  ROUND(AVG(http_0_9/num_requests) * 100,2) avg_pct_http_0_9,
  ROUND(AVG(http_1_0/num_requests) * 100,2) avg_pct_http_1_0,  
  ROUND(AVG(http_1_1/num_requests) * 100,2) avg_pct_http_1_1,
  ROUND(AVG(http_2/num_requests) * 100,2) avg_pct_http_2,
  ROUND(AVG(quic/num_requests) * 100,2) avg_pct_quic
FROM (
  SELECT 
    client,
    page,
    COUNT(0) AS num_requests, 
    SUM(IF(JSON_EXTRACT_SCALAR(payload, "$._protocol") ="http/0.9",1,0)) AS http_0_9, 
    SUM(IF(JSON_EXTRACT_SCALAR(payload, "$._protocol") ="http/1.0",1,0)) AS http_1_0, 
    SUM(IF(JSON_EXTRACT_SCALAR(payload, "$._protocol") ="http/1.1",1,0)) AS http_1_1,
    SUM(IF(JSON_EXTRACT_SCALAR(payload, "$._protocol") ="HTTP/2",1,0)) AS http_2,
    SUM(IF(JSON_EXTRACT_SCALAR(payload, "$._protocol") ="QUIC",1,0)) AS quic    
  FROM 
    `httparchive.almanac.requests`
  WHERE
    date = '2020-09-01'
  GROUP BY
    client,
    page
)
GROUP BY 
  client
