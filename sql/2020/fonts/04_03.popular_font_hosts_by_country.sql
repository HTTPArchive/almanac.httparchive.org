#standardSQL
#popular_fonts_host_by_country
SELECT
  client,
  country,
  host,
  pages,
  total,
  pct
FROM
(
  SELECT
    client,
    country,
    NET.HOST(url) AS host,
    COUNT(DISTINCT page) AS pages,
    SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client) AS total,
    COUNT(DISTINCT page) / SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client) AS pct,
    ROW_NUMBER() OVER (PARTITION BY client, country ORDER BY COUNT(DISTINCT page) DESC) AS sort_row
  FROM
    `httparchive.almanac.requests`
  JOIN (
    SELECT DISTINCT
      origin, device,
      `chrome-ux-report`.experimental.GET_COUNTRY(country_code) AS country
    FROM
      `chrome-ux-report.materialized.country_summary`
    WHERE
      yyyymm = 202008)
  ON
    CONCAT(origin, '/') = page AND
    IF(device = 'desktop', 'desktop', 'mobile') = client
  WHERE
    type = 'font' AND
    NET.HOST(url) != NET.HOST(page) AND
    date = '2020-08-01'
  GROUP BY
    client,
    country,
    host
  ORDER BY
    pct DESC
)
WHERE sort_row <= 1
