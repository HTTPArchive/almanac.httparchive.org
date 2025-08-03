-- Section: Development
-- Question: Who is serving variable fonts?
-- Normalization: Requests (variable only) and fonts (variable only)

-- INCLUDE https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/{year}/fonts/common.sql

WITH
requests AS (
  SELECT
    date,
    client,
    url,
    SERVICE(url) AS service,
    COUNT(0) OVER (PARTITION BY date, client) AS total,
    COUNT(DISTINCT url) OVER (PARTITION BY date, client) AS total_secondary
  FROM
    `httparchive.crawl.requests`
  WHERE
    date IN UNNEST(@dates) AND
    type = 'font' AND
    is_root_page AND
    IS_VARIABLE(payload)
)

SELECT
  date,
  client,
  service,
  COUNT(0) AS count,
  COUNT(DISTINCT url) AS count_secondary,
  total,
  total_secondary,
  ROUND(COUNT(0) / total, @precision) AS proportion,
  ROUND(COUNT(DISTINCT url) / total_secondary, @precision) AS proportion_secondary
FROM
  requests
GROUP BY
  date,
  client,
  service,
  total,
  total_secondary
ORDER BY
  date,
  client,
  proportion DESC
