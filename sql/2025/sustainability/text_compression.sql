WITH content_encoding AS (
  SELECT
    client,
    LOWER(h.value) AS encoding
  FROM `httparchive.crawl.requests`
  LEFT JOIN UNNEST(r.response_headers) AS h
  ON LOWER(h.name) = 'content-encoding'
  WHERE
    date = '2025-07-01' AND
    is_root_page AND
    is_main_document
),

compression_rollup AS (
  SELECT
    client,
    CASE
      WHEN encoding = 'gzip' THEN 'Gzip'
      WHEN encoding = 'br' THEN 'Brotli'
      WHEN encoding IS NULL OR encoding = '' THEN 'no text compression'
      ELSE 'other'
    END AS compression_type,
    COUNT(0) AS num_requests,
    SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
    ROUND(
      COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) * 100, 2
    ) AS pct
  FROM content_encoding
  GROUP BY client, compression_type
)

SELECT
  client,
  compression_type,
  num_requests,
  total,
  pct
FROM compression_rollup
ORDER BY client ASC, num_requests DESC;
