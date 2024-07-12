-- Section: Performance
-- Question: What is the distribution of the file size broken down by country?

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
    NET.HOST(page) AS domain,
    AVG(PARSE_NUMERIC(header.value)) AS size
  FROM
    `httparchive.all.requests`,
    UNNEST(response_headers) AS header
  WHERE
    date = '2024-06-01' AND
    type = 'font' AND
    LOWER(header.name) = 'content-length' AND
    TRIM(header.value) != ''
  GROUP BY
    client,
    domain
)

SELECT
  client,
  country,
  COUNT(0) AS count,
  APPROX_QUANTILES(size, 1000)[OFFSET(500)] AS median_size
FROM
  fonts
JOIN
  countries USING (client, domain)
GROUP BY
  client,
  country
ORDER BY
  client,
  country
