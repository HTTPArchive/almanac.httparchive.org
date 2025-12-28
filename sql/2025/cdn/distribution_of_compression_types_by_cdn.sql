#standardSQL
# distribution_of_compression_types_by_cdn.sql : What compression formats are being used (gzip, brotli, etc) for compressed resources served by CDNs

SELECT
  client,
  cdn,
  compression_type,
  COUNT(0) AS num_requests,
  SUM(COUNT(0)) OVER (PARTITION BY client, cdn) AS total_compressed,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client, cdn) AS pct
FROM (
  SELECT
    client,
    IFNULL(NULLIF(REGEXP_EXTRACT(JSON_EXTRACT_SCALAR(summary, '$._cdn_provider'), r'^([^,]*).*'), ''), 'ORIGIN') AS cdn, # sometimes _cdn provider detection includes multiple entries. we bias for the DNS detected entry which is the first entry
    CASE
      WHEN a.value = 'gzip' THEN 'Gzip'
      WHEN a.value = 'br' THEN 'Brotli'
      WHEN a.value = '' THEN 'no text compression'
      ELSE 'other'
    END AS compression_type
  FROM
    `httparchive.crawl.requests`
  CROSS JOIN UNNEST(response_headers) AS a
  WHERE
    date = '2025-07-01' AND
    a.name = 'content-encoding'
-- resp_content_encoding != ''
)
GROUP BY
  client,
  cdn,
  compression_type
ORDER BY
  client,
  cdn,
  compression_type
