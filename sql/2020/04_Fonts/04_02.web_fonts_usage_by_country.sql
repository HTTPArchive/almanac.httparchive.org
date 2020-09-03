#standardSQL
#web_fonts_usage_by_country_2020
SELECT
 _TABLE_SUFFIX AS client,
 country,
 COUNT(0) AS freq_url,
 ROUND(APPROX_QUANTILES(bytesFont, 1000)[OFFSET(500)] / 1024, 2) AS median_font_bytes
FROM (
SELECT
 DISTINCT origin,
 `chrome-ux-report`.experimental.GET_COUNTRY(country_code) AS country
FROM 
  `chrome-ux-report.materialized.country_summary`
WHERE 
  yyyymm = 202007)
JOIN 
  `httparchive.summary_pages.2020_08_01_*`
ON 
  CONCAT(origin, '/') = url
WHERE 
  bytesFont IS NOT NULL
GROUP BY
 client,
 country
ORDER BY
 client,
 country
