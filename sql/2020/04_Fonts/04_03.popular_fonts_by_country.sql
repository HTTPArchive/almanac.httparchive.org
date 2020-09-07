#standardSQL
#popular fonts by country(??too_many_rows)
SELECT
  client,
  country,
  NET.HOST(url) AS url_font,
  COUNT(0) AS freq_font,
  COUNT(0) OVER (PARTITION BY country) AS country_total,
  ROUND(COUNT(0)/COUNT(0) OVER (PARTITION BY country),2) AS pct_country,
FROM
  `httparchive.almanac.requests`
JOIN (
  SELECT
    DISTINCT origin,
    `chrome-ux-report`.experimental.GET_COUNTRY(country_code) AS country
  FROM
    `chrome-ux-report.materialized.country_summary`
  WHERE
    yyyymm=202007)
ON
  CONCAT(origin, '/')=page
WHERE
  type='font'
  AND NET.HOST(url)!=NET.HOST(page)
  AND date='2020-08-01'
GROUP BY
  client,
  country,
  url
