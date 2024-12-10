#standardSQL
# Pages which had resources from domains with both h2 and h3 requests
#

SELECT
  date,
  client,
  page,
  url_host,
  COUNTIF(protocol IN ('HTTP/2', 'h2')) AS h2_requests,
  COUNTIF(protocol IN ('HTTP/3', 'h3', 'h3-29')) AS h3_requests
FROM (
  SELECT
    date,
    client,
    page,
    NET.HOST(url) AS url_host,
    JSON_EXTRACT_SCALAR(summary, '$.respHttpVersion') AS protocol
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-06-01' AND
    is_root_page)
GROUP BY
  date,
  client,
  page,
  url_host
HAVING
  h2_requests > 0 AND
  h3_requests > 0
ORDER BY
  date,
  client,
  page,
  url_host
