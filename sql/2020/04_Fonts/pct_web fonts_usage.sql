#standardSQL
#web fonts usage (this query my process 4.5G)
SELECT
  _TABLE_SUFFIX AS client,
  SUBSTR(_TABLE_SUFFIX, 0, 10) AS date,
  COUNTIF(reqFont>0) AS req_fonts,
  COUNT(0) AS total_fonts,
  ROUND(COUNTIF(reqFont>0) * 100 / count(0),2) AS pct_fonts,
  ROUND(APPROX_QUANTILES(bytesFont , 1000)[OFFSET (500)]/1024,2) AS median_bytesFont,
  ROUND(APPROX_QUANTILES(PageSpeed, 1000)[OFFSET (500)]/count(0),2) AS median_PageSpeed,
FROM `httparchive.summary_pages.*`
WHERE
  bytesFont>0
GROUP BY
  date, client
ORDER BY
  date DESC, client
