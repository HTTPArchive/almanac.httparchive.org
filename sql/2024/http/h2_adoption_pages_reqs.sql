#standardSQL

# Percentage of websites using HTTP/2+ vs HTTP/1.1; this is based on the home
# page.

SELECT
  client,
  protocol,
  CASE
    WHEN LOWER(protocol) = 'quic' OR LOWER(protocol) LIKE 'h3%' THEN 'HTTP/2+'
    WHEN LOWER(protocol) = 'http/2' OR LOWER(protocol) = 'http/3' THEN 'HTTP/2+'
    WHEN protocol IS NULL THEN 'Unknown'
    ELSE UPPER(protocol)
  END AS http_version_category,
  CASE
    WHEN LOWER(protocol) LIKE 'h3%' OR LOWER(protocol) = 'quic' THEN 'HTTP/3'
    WHEN protocol IS NULL THEN 'Unknown'
    ELSE UPPER(protocol)
  END AS http_version,
  COUNT(0) AS num_reqs,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_reqs,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct_reqs,
  COUNTIF(is_main_document) AS num_pages,
  SUM(COUNTIF(is_main_document)) OVER (PARTITION BY client) AS total_pages,
  COUNTIF(is_main_document) / SUM(COUNTIF(is_main_document)) OVER (PARTITION BY client) AS pct_pages
FROM (
  SELECT
    client,
    is_main_document,
    JSON_EXTRACT_SCALAR(summary, '$.respHttpVersion') AS protocol
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-06-01' AND
    is_root_page
)
GROUP BY
  client,
  protocol
ORDER BY
  client ASC,
  num_reqs DESC
