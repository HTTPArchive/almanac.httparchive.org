-- Section: Performance
-- Question: What is the distribution of the file size broken down by country?
-- Normalization: Fonts on sites

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
    yyyymm = 202407
  GROUP BY
    client,
    domain,
    country
),
requests AS (
  SELECT
    client,
    NET.HOST(page) AS domain,
    FILE_FORMAT(
      JSON_EXTRACT_SCALAR(summary, '$.ext'),
      JSON_EXTRACT_SCALAR(summary, '$.mimeType')
    ) AS format,
    PARSE_NUMERIC(JSON_EXTRACT_SCALAR(summary, '$.respBodySize')) AS size
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND
    is_root_page AND
    type = 'font'
),
formats AS (
  SELECT
    client,
    country,
    format,
    ROW_NUMBER() OVER (PARTITION BY client, country ORDER BY COUNT(0) DESC) AS rank
  FROM
    requests
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
  COUNT(0) AS count,
  ROUND(APPROX_QUANTILES(size, 1000)[OFFSET(500)]) AS size
FROM
  requests
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
