#standardSQL
# Section: Attack preventions - Preventing attacks using Clear-Site-Data
# Question: Which Clear-Site-Data header values are most prevalent?
# Notes: Many used values are still invalid (without quotes). We only count each host-value pair once.
SELECT
  client,
  response_headers.value AS csd_header,
  SUM(COUNT(DISTINCT NET.HOST(url))) OVER (PARTITION BY client) AS total_csd_headers,
  COUNT(DISTINCT NET.HOST(url)) AS freq,
  COUNT(DISTINCT NET.HOST(url)) / SUM(COUNT(DISTINCT NET.HOST(url))) OVER (PARTITION BY client) AS pct
FROM
  `httparchive.crawl.requests`,
  UNNEST(response_headers) AS response_headers
WHERE
  date = '2025-07-01' AND
  is_root_page AND
  # is_main_document AND # (Uncomment to only run on the main document response; majority of CSD headers are set on them)
  LOWER(response_headers.name) = 'clear-site-data'
GROUP BY
  client,
  csd_header
ORDER BY
  pct DESC
LIMIT
  100
