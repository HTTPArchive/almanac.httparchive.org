#standardSQL

# Percentage of requests using HTTP/2+ vs HTTP/1.1 broken down by whether the
# request was served from CDN.

SELECT
  client,
  _cdn_provider,
  CASE
    WHEN LOWER(protocol) = 'quic' OR LOWER(protocol) LIKE 'h3%' THEN 'HTTP/2+'
    WHEN LOWER(protocol) = 'http/2' OR LOWER(protocol) = 'http/3' THEN 'HTTP/2+'
    WHEN protocol IS NULL THEN 'Unknown'
    ELSE UPPER(protocol)
  END AS http_version_category,
  COUNT(0) AS num_reqs,
  SUM(COUNT(0)) OVER (PARTITION BY client, _cdn_provider) AS total_reqs,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client, _cdn_provider) AS pct_reqs
FROM
  `httparchive.almanac.requests`
WHERE
  date = '2022-06-01' AND
  LENGTH(_cdn_provider) > 0
GROUP BY
  client,
  _cdn_provider,
  http_version_category
ORDER BY
  client ASC,
  num_reqs DESC
