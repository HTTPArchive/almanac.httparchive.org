# standardSQL
# Measure of all HTTP versions (0.9, 1.0, 1.1, 2, QUIC) for main page of all sites, and for HTTPS sites. Table for last crawl.
SELECT
  client,
  CASE
    WHEN LOWER(protocol) = 'quic' OR LOWER(protocol) LIKE 'h3%' THEN 'HTTP/2+'
    WHEN LOWER(protocol) = 'http/2' OR LOWER(protocol) = 'http/3' THEN 'HTTP/2+'
    WHEN protocol IS NULL THEN 'Unknown'
    ELSE UPPER(protocol)
  END AS http_version_category,
  COUNT(0) AS num_pages,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNTIF(url LIKE 'https://%') AS num_https_pages,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct_pages,
  COUNTIF(url LIKE 'https://%') / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct_https_pages
FROM
  `httparchive.almanac.requests`
WHERE
  date = '2021-07-01' AND
  firstHtml
GROUP BY
  client,
  http_version_category
ORDER BY
  pct_pages DESC
