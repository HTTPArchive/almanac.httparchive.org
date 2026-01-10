-- Section: Performance
-- Question: What is the distribution of the file size broken down by country?
-- Normalization: Requests (parsed only)

-- INCLUDE https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/2024/fonts/common.sql

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
    PARSE_NUMERIC(JSON_EXTRACT_SCALAR(summary, '$.respBodySize')) AS size
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND -- noqa: CV09
    type = 'font' AND
    is_root_page AND
    IS_PARSED(payload)
)

SELECT
  client,
  country,
  COUNT(0) AS count,
  ROUND(APPROX_QUANTILES(size, 1000)[OFFSET(500)]) AS size
FROM
  requests
INNER JOIN
  countries
USING (client, domain)
GROUP BY
  client,
  country
ORDER BY
  client,
  country
