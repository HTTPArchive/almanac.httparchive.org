# standardSQL
# Measure of all HTTP versions (0.9, 1.0, 1.1, 2, QUIC) for main page of all sites, and for HTTPS sites. Table for last crawl.
SELECT
  client,
  JSON_EXTRACT_SCALAR(payload, '$._protocol') AS protocol,
  COUNT(0) AS num_pages,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNTIF(url LIKE 'https://%') AS num_https_pages,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct_pages,
  COUNTIF(url LIKE 'https://%') / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct_https
FROM
  `httparchive.almanac.requests`
WHERE
  date = '2020-08-01' AND
  firstHtml
GROUP BY
  client,
  protocol
ORDER BY
  num_pages / total DESC
