#standardSQL
# 01_11: Distribution of JS bytes for top JS frameworks
SELECT
  app,
  _TABLE_SUFFIX AS client,
  COUNT(DISTINCT url) AS freq,
  APPROX_QUANTILES(ROUND(bytesJs / 1024), 1000)[OFFSET(100)] AS p10_js_kbytes,
  APPROX_QUANTILES(ROUND(bytesJs / 1024), 1000)[OFFSET(250)] AS p25_js_kbytes,
  APPROX_QUANTILES(ROUND(bytesJs / 1024), 1000)[OFFSET(500)] AS median_js_kbytes,
  APPROX_QUANTILES(ROUND(bytesJs / 1024), 1000)[OFFSET(750)] AS p75_js_kbytes,
  APPROX_QUANTILES(ROUND(bytesJs / 1024), 1000)[OFFSET(900)] AS p90_js_kbytes
FROM
  `httparchive.summary_pages.2019_07_01_*`
JOIN
  `httparchive.technologies.2019_07_01_*`
USING (_TABLE_SUFFIX, url)
WHERE
  category = 'JavaScript Frameworks'
GROUP BY
  app,
  client
ORDER BY
  freq DESC
