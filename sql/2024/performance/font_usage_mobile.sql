SELECT
  COUNTIF(SAFE_CAST(JSON_EXTRACT_SCALAR(summary, '$.reqFont') AS INT64) > 0) AS freq_fonts,
  COUNT(0) AS total,
  COUNTIF(SAFE_CAST(JSON_EXTRACT_SCALAR(summary, '$.reqFont') AS INT64) > 0) / COUNT(0) AS pct_fonts
FROM
  `httparchive.all.pages`
WHERE
  date = '2024-06-01' AND
  client = 'mobile' AND
  is_root_page AND
  SAFE_CAST(JSON_EXTRACT_SCALAR(summary, '$.reqFont') AS INT64) IS NOT NULL AND
  SAFE_CAST(JSON_EXTRACT_SCALAR(summary, '$.bytesFont') AS INT64) IS NOT NULL
