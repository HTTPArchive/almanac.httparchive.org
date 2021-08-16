#standardSQL
#19_14: Count of HTTP/2 Sites using HTTP/2 Push
SELECT
  client,
  COUNT(DISTINCT IF(JSON_EXTRACT_SCALAR(payload, '$._was_pushed') = '1', page, NULL)) AS num_pages,
  COUNT(DISTINCT page) AS total,
  COUNT(DISTINCT IF(JSON_EXTRACT_SCALAR(payload, '$._was_pushed') = '1', page, NULL)) / COUNT(DISTINCT page) AS pct
FROM
  `httparchive.almanac.requests`
WHERE
  date = '2020-08-01' AND
  JSON_EXTRACT_SCALAR(payload, '$._protocol') = 'HTTP/2'
GROUP BY
  client
