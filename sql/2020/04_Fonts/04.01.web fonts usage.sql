#standardSQL
#web fonts usage
SELECT
 _TABLE_SUFFIX AS client,
 SUBSTR(_TABLE_SUFFIX, 0, 10) AS date,
 COUNTIF(reqFont>0) AS freq_fonts,
 COUNT(0) AS total,
 ROUND(COUNTIF(reqFont>0) * 100 / count(0),2) AS pct_fonts,
 ROUND(APPROX_QUANTILES(bytesFont , 1000)[OFFSET (500)]/1024,2) AS median_byteFont,
FROM `httparchive.summary_pages.*`
WHERE reqFont IS NOT NULL and bytesFont IS NOT NULL
GROUP BY client, date
ORDER BY client, date DESC
