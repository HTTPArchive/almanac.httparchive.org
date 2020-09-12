#standardSQL
#popular_fonts_host_by_country
SELECT
  client,
  url_font,
  country,
  freq_font,
  country_total,
  pct_country
FROM 
(
  SELECT
    client,
    country,
    NET.HOST(url) AS url_font,
    COUNT(0) AS freq_font,
    COUNT(0) OVER (PARTITION BY client) AS country_total,
    ROUND(COUNT(0)/COUNT(0) OVER (PARTITION BY client),2) AS pct_country,
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
