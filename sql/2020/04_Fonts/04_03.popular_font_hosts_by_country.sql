#standardSQL
#popular_country_font_usage_by_host
SELECT
  client,
  country,
  url_font,
  freq_font,
  country_total,
  pct_country,
FROM (
  SELECT
    client,
    country,
    NET.HOST(url) AS url_font,
    COUNT(DISTINCT page) AS freq_font,
    COUNT(DISTINCT page) OVER (PARTITION BY country) AS country_total,
    COUNT(DISTINCT page) / COUNT(DISTINCT page) OVER (PARTITION BY country) AS pct_country,
  FROM (
    SELECT
      client,
      url,
      page,
      COUNTIF(NET.HOST(page) = NET.HOST(url)) / COUNT(0) AS pct_locally_hosted
    FROM
      `httparchive.almanac.requests`
    WHERE
      date = '2020-08-01'
      AND type = 'font'
    GROUP BY
      client,
      page,
      url)
  JOIN (
    SELECT
      DISTINCT origin,
      device,
      `chrome-ux-report`.experimental.GET_COUNTRY(country_code) AS country
    FROM
      `chrome-ux-report.materialized.country_summary`
    WHERE
      yyyymm=202008)
  ON
    CONCAT(origin, '/')=page AND
    IF(device='desktop', 'desktop', 'mobile')=client
  WHERE
    pct_locally_hosted!=1 AND country='Korea, Republic of' AND country='Iran (Islamic Republic of)' AND country='Turkey' AND country='Slovenia' AND country='Australia' AND country='Greece' AND country='United States of America' AND country='China' AND country='British Indian Ocean Territory' AND country='Eritrea' AND country='Falkland Islands (Malvinas)' AND country='Saint Helena, Ascension and Tristan da Cunha' AND country='Macaoa' AND country='Japan' AND country='China' 
GROUP BY
    client,
    page,
    country,
    url_font)
ORDER BY
   freq_font, country DESC