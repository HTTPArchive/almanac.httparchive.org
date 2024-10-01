#standardSQL

# Percentage of requests with HTTP/3 support broken down by whether the
# request was served from CDN.

SELECT
  client,
  _cdn_provider,
  CASE
    WHEN protocol IN ('HTTP/3', 'h3', 'h3-29') OR
      protocol IN ('HTTP/3', 'h3', 'h3-29') OR
      alt_svc LIKE '%h3=%' OR
      alt_svc LIKE '%h3-29=%' THEN 'h3_supported'
    ELSE 'h3_not_supported'
  END AS h3_status,
  COUNT(0) AS num_reqs,
  SUM(COUNT(0)) OVER (PARTITION BY client, _cdn_provider) AS total_reqs,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client, _cdn_provider) AS pct_reqs
FROM (
  SELECT
    client,
    JSON_EXTRACT_SCALAR(summary, '$._cdn_provider') AS _cdn_provider,
    JSON_EXTRACT_SCALAR(summary, '$.respHttpVersion') AS protocol,
    resp_headers.value AS alt_svc
  FROM
    `httparchive.all.requests`
  LEFT OUTER JOIN
    UNNEST(response_headers) AS resp_headers ON LOWER(resp_headers.name) = 'alt-svc'
  WHERE
    date = '2024-06-01' AND
    is_root_page AND
    LENGTH(JSON_EXTRACT_SCALAR(summary, '$._cdn_provider')) > 0)
GROUP BY
  client,
  _cdn_provider,
  h3_status
ORDER BY
  client ASC,
  num_reqs DESC
