#standardSQL
#party of content encoding
SELECT
  client,
  IF(NET.HOST(url) IN (
    SELECT
      domain
    FROM
      `httparchive.almanac.third_parties`
    WHERE
      date = '2020-08-01' AND
      category != 'hosting'
  ), 'third party', 'first party') AS party
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
