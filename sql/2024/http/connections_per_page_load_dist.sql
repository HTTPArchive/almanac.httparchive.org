#standardSQL

# Measure the distribution of TCP Connections per site.

SELECT
  percentile,
  client,
  http_version_category,
  COUNT(0) AS num_pages,
  APPROX_QUANTILES(_connections, 1000)[OFFSET(percentile * 10)] AS connections
FROM (
  SELECT
    client,
    page,
    CASE
      WHEN LOWER(JSON_EXTRACT_SCALAR(summary, '$.respHttpVersion')) = 'quic' OR LOWER(JSON_EXTRACT_SCALAR(summary, '$.respHttpVersion')) LIKE 'h3%' THEN 'HTTP/2+'
      WHEN LOWER(JSON_EXTRACT_SCALAR(summary, '$.respHttpVersion')) = 'http/2' OR LOWER(JSON_EXTRACT_SCALAR(summary, '$.respHttpVersion')) = 'http/3' THEN 'HTTP/2+'
      WHEN JSON_EXTRACT_SCALAR(summary, '$.respHttpVersion') IS NULL THEN 'Unknown'
      ELSE 'Non-HTTP/2'
    END AS http_version_category
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-06-01' AND
    is_root_page AND
    is_main_document
)
JOIN (
  SELECT
    client,
    page,
    CAST(JSON_EXTRACT_SCALAR(summary, '$._connections') AS INT64) AS _connections
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01' AND
    is_root_page
)
USING (client, page),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client,
  http_version_category
ORDER BY
  percentile,
  client,
  num_pages DESC,
  http_version_category
