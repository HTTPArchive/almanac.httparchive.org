#standardSQL

# Percentage of requests using HTTP/2+ vs HTTP/1.1 broken down by whether the
# request was served from CDN.

SELECT
  client,
  cdn,
  CASE
    WHEN LOWER(protocol) = 'quic' OR LOWER(protocol) LIKE 'h3%' THEN 'HTTP/2+'
    WHEN LOWER(protocol) = 'http/2' OR LOWER(protocol) = 'http/3' THEN 'HTTP/2+'
    WHEN protocol IS NULL THEN 'Unknown'
    ELSE UPPER(protocol)
  END AS http_version_category,
  COUNT(0) AS num_reqs,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_reqs,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct_reqs
FROM (
  SELECT
    client,
    CASE
      WHEN LENGTH(JSON_EXTRACT_SCALAR(summary, '$._cdn_provider')) > 0 THEN 'from-cdn'
      ELSE 'non-cdn'
    END AS cdn,
    JSON_EXTRACT_SCALAR(summary, '$.respHttpVersion') AS protocol
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2022-06-01' AND
    is_root_page
)
GROUP BY
  client,
  cdn,
  http_version_category
ORDER BY
  client ASC,
  num_reqs DESC
