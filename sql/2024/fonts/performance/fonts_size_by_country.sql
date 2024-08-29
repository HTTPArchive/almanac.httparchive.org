-- Section: Performance
-- Question: What is the distribution of the file size broken down by country?

-- INCLUDE ../common.sql

WITH
countries AS (
  SELECT
    IF(device = 'desktop', 'desktop', 'mobile') AS client,
    NET.HOST(origin) AS domain,
    `chrome-ux-report`.experimental.GET_COUNTRY(country_code) AS country
  FROM
    `chrome-ux-report.materialized.country_summary`
  WHERE
    yyyymm = 202406
  GROUP BY
    client,
    domain,
    country
),
fonts AS (
  SELECT
    client,
    url,
    NET.HOST(ANY_VALUE(page)) AS domain,
    FILE_FORMAT(
      JSON_EXTRACT_SCALAR(ANY_VALUE(summary), '$.ext'),
      JSON_EXTRACT_SCALAR(ANY_VALUE(summary), '$.mimeType')
    ) AS format,
    PARSE_NUMERIC(JSON_EXTRACT_SCALAR(ANY_VALUE(summary), '$.respBodySize')) AS size
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND
    type = 'font'
  GROUP BY
    client,
    url
),
formats AS (
  SELECT
    client,
    country,
    format,
    ROW_NUMBER() OVER (PARTITION BY client, country ORDER BY COUNT(DISTINCT url) DESC) AS rank
  FROM
    fonts
  INNER JOIN
    countries USING (client, domain)
  GROUP BY
    client,
    country,
    format
)

SELECT
  client,
  country,
  format,
  COUNT(DISTINCT url) AS count,
  ROUND(APPROX_QUANTILES(size, 1000)[OFFSET(500)]) AS size
FROM
  fonts
INNER JOIN
  countries USING (client, domain)
INNER JOIN
  formats USING (client, country, format)
WHERE
  rank <= 10
GROUP BY
  client,
  country,
  format,
  rank
ORDER BY
  client,
  country,
  rank
