#standardSQL
#popular fonts by country
SELECT
 client,
 country,
 NET.HOST(url) AS url_font,
 COUNT(0) AS freq_font,
 COUNT(0) OVER (PARTITION BY country) AS country_total,
 ROUND(COUNT(0)/COUNT(0) OVER (PARTITION BY country),2) AS pct_country,
from 
 `httparchive.almanac.requests`
join 
 (SELECT DISTINCT origin,`chrome-ux-report`.experimental.GET_COUNTRY(country_code) AS country
FROM 
 `chrome-ux-report.materialized.country_summary` WHERE yyyymm=202007)
ON 
 CONCAT(origin, '/')=page
WHERE 
 type='font' AND NET.HOST(url)!=NET.HOST(page)
GROUP BY 
 client, country, url
