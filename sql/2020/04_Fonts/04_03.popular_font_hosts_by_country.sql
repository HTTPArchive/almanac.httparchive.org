#standardSQL
#popular_fonts_host_by_country
SELECT
  client,
  country,
  url_font,
  freq_font,
  country_total,
  pct_country,
  RANK() OVER (PARTITION BY country ORDER BY pct_country DESC) AS rank
FROM 
(
  SELECT
    client,
    country,
    NET.HOST(url) AS url_font,
    COUNT(0) AS freq_font,
    SUM(COUNT(0)) OVER (PARTITION BY country) AS country_total,
    ROUND(COUNT(0)/SUM(COUNT(0)) OVER (PARTITION BY country),2) AS pct_country,
    ROW_NUMBER() OVER (PARTITION BY client, country ORDER BY COUNT(0) DESC) AS rank
  FROM
    `httparchive.almanac.requests`
  JOIN (
    SELECT
      DISTINCT origin,
      `chrome-ux-report`.experimental.GET_COUNTRY(country_code) AS country
    FROM
      `chrome-ux-report.materialized.country_summary`
    WHERE
      yyyymm=202008)
  ON
    CONCAT(origin, '/')=page
  WHERE
    type='font'
    AND NET.HOST(url)!=NET.HOST(page)
    AND date='2020-08-01'
  GROUP BY
    client,
    url_font,
    country
)
WHERE rank <= 10
