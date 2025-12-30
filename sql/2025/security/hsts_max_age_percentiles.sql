#standardSQL
# Section: Transport Security - HTTP Strict Transport Security
# Question: What is the distribution of max-age values for HSTS?
SELECT
  client,
  percentile,
  APPROX_QUANTILES(max_age, 1000 IGNORE NULLS)[OFFSET(percentile * 10)] AS max_age
FROM (
  SELECT
    client,
    SAFE_CAST(REGEXP_EXTRACT(response_headers.value, r'(?i)max-age=\s*(-?\d+)') AS NUMERIC) AS max_age
  FROM
    `httparchive.crawl.requests`,
    UNNEST(response_headers) AS response_headers
  WHERE
    date = '2025-07-01' AND
    is_root_page AND
    LOWER(response_headers.name) = 'strict-transport-security'
),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
