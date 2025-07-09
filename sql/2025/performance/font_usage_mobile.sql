SELECT
  COUNTIF(SAFE_CAST(JSON_VALUE(summary.reqFont) AS INT64) > 0) AS freq_fonts,
  COUNT(0) AS total,
  COUNTIF(SAFE_CAST(JSON_VALUE(summary.reqFont) AS INT64) > 0) / COUNT(0) AS pct_fonts
FROM
  `httparchive.crawl.pages`
WHERE
  date = '2025-06-01' AND
  client = 'mobile' AND
  is_root_page AND
  SAFE_CAST(JSON_VALUE(summary.reqFont) AS INT64) IS NOT NULL AND
  SAFE_CAST(JSON_VALUE(summary.bytesFont) AS INT64) IS NOT NULL
