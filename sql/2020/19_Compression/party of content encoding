#standardSQL
#party of content encoding
SELECT
  client,
  CASE
   WHEN req_host!= ' ' THEN 'first-party'
   ELSE 'thrid-party' END
  AS party,
  resp_content_encoding,
  COUNT(0) AS num_requests,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  `httparchive.sample_data.requests`
WHERE
  date='2020-08-01'
GROUP BY
  client,
  req_host,
  resp_content_encoding
ORDER BY
  num_requests DESC