#standardSQL
SELECT
  REPLACE(SUBSTR(_TABLE_SUFFIX, 0, 10), '_', '') AS date,
  IF(ENDS_WITH(_TABLE_SUFFIX, 'desktop'), 'desktop', 'mobile') AS client,
  ROUND(APPROX_QUANTILES(bytesTotal, 1000)[OFFSET(100)] / 1024, 2) AS p10,
  ROUND(APPROX_QUANTILES(bytesTotal, 1000)[OFFSET(250)] / 1024, 2) AS p25,
  ROUND(APPROX_QUANTILES(bytesTotal, 1000)[OFFSET(500)] / 1024, 2) AS p50,
  ROUND(APPROX_QUANTILES(bytesTotal, 1000)[OFFSET(750)] / 1024, 2) AS p75,
  ROUND(APPROX_QUANTILES(bytesTotal, 1000)[OFFSET(900)] / 1024, 2) AS p90
FROM
  `httparchive.summary_pages.*`
WHERE
  bytesTotal > 0 AND
  SUBSTR(_TABLE_SUFFIX, 9, 2) = '01' -- ignore mid-month figures as not always available and throws off chart
GROUP BY
  date,
  client
ORDER BY
  date DESC,
  client
