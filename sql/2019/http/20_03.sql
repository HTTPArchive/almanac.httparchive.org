#standardSQL
# 20.03 - Average percentage of resources loaded over HTTP/2 or HTTP/1.1 per site
SELECT
  client,
  ROUND(AVG(http_1_1 / num_requests) * 100, 2) AS avg_pct_http_1_1,
  ROUND(AVG(http_2 / num_requests) * 100, 2) AS avg_pct_http_2
FROM (
  SELECT
    client,
    page,
    COUNT(0) AS num_requests,
    SUM(IF(JSON_EXTRACT_SCALAR(payload, "$._protocol") = "http/0.9", 1, 0)) AS http_0_9,
    SUM(IF(JSON_EXTRACT_SCALAR(payload, "$._protocol") = "http/1.0", 1, 0)) AS http_1_0,
    SUM(IF(JSON_EXTRACT_SCALAR(payload, "$._protocol") = "http/1.1", 1, 0)) AS http_1_1,
    SUM(IF(JSON_EXTRACT_SCALAR(payload, "$._protocol") = "HTTP/2", 1, 0)) AS http_2
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2019-07-01'
  GROUP BY
    client,
    page
)
GROUP BY
  client
