SELECT
  IF(ENDS_WITH(_TABLE_SUFFIX, 'desktop'), 'desktop', 'mobile') AS client,
  REGEXP_REPLACE(_TABLE_SUFFIX, r'(\d+)_(\d+)_(\d+).*', r'\1-\2-\3') AS date,
  COUNTIF(reqFont > 0) AS freq_fonts,
  COUNT(0) AS total,
  COUNTIF(reqFont > 0) / COUNT(0) AS pct_fonts
FROM
  `httparchive.summary_pages.*`
WHERE
  reqFont IS NOT NULL AND
  bytesFont IS NOT NULL
GROUP BY
  client,
  date
ORDER BY
  date DESC,
  client
