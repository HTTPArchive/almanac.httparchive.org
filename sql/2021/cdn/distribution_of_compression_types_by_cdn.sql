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
    IFNULL(NULLIF(REGEXP_EXTRACT(_cdn_provider, r'^([^,]*).*'), ''), 'ORIGIN') AS cdn, # sometimes _cdn provider detection includes multiple entries. we bias for the DNS detected entry which is the first entry
    CASE
      WHEN resp_content_encoding = 'gzip' THEN 'Gzip'
      WHEN resp_content_encoding = 'br' THEN 'Brotli'
      WHEN resp_content_encoding = '' THEN 'no text compression'
      ELSE 'other'
    END AS compression_type
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2021-07-01' AND
    resp_content_encoding != ''
  )
GROUP BY
  client,
  cdn,
  compression_type
ORDER BY
  client,
  cdn,
  compression_type
