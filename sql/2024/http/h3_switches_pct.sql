WITH requests AS (
  SELECT DISTINCT
    date,
    client,
    page,
    NET.HOST(url) AS url_host,
    JSON_EXTRACT_SCALAR(summary, '$.respHttpVersion') AS protocol,
    resp_headers.value AS alt_svc
  FROM
    `httparchive.crawl.requests`
  JOIN
    UNNEST(response_headers) AS resp_headers ON LOWER(resp_headers.name) = 'alt-svc'
  WHERE
    date = '2024-06-01' AND
    is_root_page
),

url_host_totals AS (
  SELECT
    date,
    client,
    url_host,
    COUNT(DISTINCT page) AS total_pages
  FROM
    requests
  WHERE
    alt_svc LIKE '%h3%' AND
    protocol IN ('HTTP/2', 'h2')
  GROUP BY
    date,
    client,
    url_host
)

SELECT
  client,
  url_host,
  COUNT(DISTINCT page) AS switched_pages,
  total_pages,
  COUNT(DISTINCT page) / total_pages AS pct_pages,
  ARRAY_TO_STRING(ARRAY_AGG(DISTINCT page LIMIT 5), ', ') AS sample_urls
FROM
  url_host_totals
JOIN (
  SELECT
    date,
    client,
    page,
    url_host,
    COUNTIF(protocol IN ('HTTP/2', 'h2')) AS h2_requests,
    COUNTIF(protocol IN ('HTTP/3', 'h3', 'h3-29')) AS h3_requests
  FROM
    requests
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
)
USING (date, client, url_host)
GROUP BY
  client,
  url_host,
  total_pages
HAVING
  switched_pages > 10
ORDER BY
  switched_pages DESC,
  client,
  url_host
