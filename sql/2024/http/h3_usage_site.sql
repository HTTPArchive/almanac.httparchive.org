#standardSQL
# Whether sites use HTTP/3
# As HTTP Archive does a cold crawl, immediate usage suggests either support advertised why DNS
# or home page redirect and browser upgrades
#

SELECT
  date,
  client,
  CASE
    WHEN protocol IN ('HTTP/3', 'h3', 'h3-29') OR
      protocol IN ('HTTP/3', 'h3', 'h3-29') THEN 'h3_used'
    ELSE 'h3_not_used'
  END AS h3_used,
  CASE
    WHEN protocol IN ('HTTP/3', 'h3', 'h3-29') OR
      protocol IN ('HTTP/3', 'h3', 'h3-29') OR
      alt_svc LIKE '%h3=%' OR
      alt_svc LIKE '%h3-29=%' THEN 'h3_supported'
    ELSE 'h3_not_supported'
  END AS h3_supported,
  COUNT(DISTINCT page) AS num_pages,
  SUM(COUNT(DISTINCT page)) OVER (PARTITION BY date, client) AS total_pages,
  COUNT(DISTINCT page) / SUM(COUNT(DISTINCT page)) OVER (PARTITION BY date, client) AS pct_pages
FROM (
  SELECT
    date,
    client,
    page,
    is_main_document,
    JSON_EXTRACT_SCALAR(summary, '$.respHttpVersion') AS protocol,
    resp_headers.value AS alt_svc
  FROM
    `httparchive.all.requests`
  LEFT OUTER JOIN
    UNNEST(response_headers) AS resp_headers ON LOWER(resp_headers.name) = 'alt-svc'
  WHERE
    date = '2024-06-01' AND
    is_root_page AND
    is_main_document)
GROUP BY
  date,
  client,
  h3_used,
  h3_supported
ORDER BY
  date,
  client,
  h3_used,
  h3_supported
