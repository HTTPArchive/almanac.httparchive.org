# standardSQL
# Average percentage of resources loaded over HTTP .9, 1, 1.1, 2, and QUIC per site
SELECT
  client,
  protocol,
  AVG(num_requests / total_requests) AS avg_pct_requests_per_page
FROM (
  SELECT 
    client,
    page,
    IF(JSON_EXTRACT_SCALAR(payload, '$._protocol') IN ('http/0.9', 'http/1.0', 'http/1.1', 'HTTP/2', 'QUIC'), JSON_EXTRACT_SCALAR(payload, '$._protocol'), 'other') AS protocol,
    COUNT(0) AS num_requests,
    SUM(COUNT(0)) OVER (PARTITION BY client, page) AS total_requests
  FROM 
    `httparchive.almanac.requests`
  WHERE
    date = '2020-08-01'
  GROUP BY
    client,
    page,
    protocol)
GROUP BY 
  client,
  protocol
ORDER BY
  avg_pct_requests_per_page DESC
