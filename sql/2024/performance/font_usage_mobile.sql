SELECT
  COUNTIF(reqFont > 0) AS freq_fonts,
  COUNT(0) AS total,
  COUNTIF(reqFont > 0) / COUNT(0) AS pct_fonts
FROM
  `httparchive.summary_pages.2024_06_01_mobile`
WHERE
  reqFont IS NOT NULL AND
  bytesFont IS NOT NULL
