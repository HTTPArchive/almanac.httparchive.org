#standardSQL
#web_fonts_usage
SELECT
IF
  (ENDS_WITH(_TABLE_SUFFIX,'desktop'),
    'desktop',
    'mobile') AS client,
  REGEXP_REPLACE(_TABLE_SUFFIX, r'(\d+)_(\d+)_(\d+).*', r'\1-\2-\3') AS date,
  COUNTIF(reqFont>0) AS freq_fonts,
  COUNT(0) AS total,
  ROUND(COUNTIF(reqFont>0) * 100 / COUNT(0),2) AS pct_fonts,
  ROUND(APPROX_QUANTILES(bytesFont, 1000)[
  OFFSET
    (500)]/1024,2) AS median_byteFont,
FROM
  `httparchive.summary_pages.*`
WHERE
  reqFont IS NOT NULL
  AND bytesFont IS NOT NULL
GROUP BY
  client,
  year,
  month
ORDER BY
  client,
  year,
  month DESC
