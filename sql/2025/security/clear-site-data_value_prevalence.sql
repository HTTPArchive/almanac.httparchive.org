#standardSQL
# Section: Attack preventions - Preventing attacks using Clear-Site-Data
# Question: Which Clear-Site-Data header values are most prevalent?
# Notes: Many used values are still invalid (without quotes). We only count each host-value pair once.
SELECT
  client,
  csd_header,
  SUM(COUNT(DISTINCT host)) OVER (PARTITION BY client) AS total_csd_headers,
  COUNT(DISTINCT host) AS freq,
  COUNT(DISTINCT host) / SUM(COUNT(DISTINCT host)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    client,
    NET.HOST(url) AS host,
    response_headers.value AS csd_header
  FROM
    `httparchive.all.requests`,
    UNNEST(response_headers) AS response_headers
  WHERE
    date = '2024-06-01' AND
    is_root_page AND
    # AND is_main_document # (Uncomment to only run on the main document response; majority of CSD headers are set on them)
    LOWER(response_headers.name) = 'clear-site-data'
)
GROUP BY
  client,
  csd_header
ORDER BY
  pct DESC
LIMIT
  100
