-- Section: Performance
-- Question: Which service combinations are popular?
-- Normalization: Pages

-- INCLUDE https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/{year}/fonts/common.sql

WITH
services_1 AS (
  SELECT
    date,
    client,
    page,
    STRING_AGG(DISTINCT SERVICE(url), ', ' ORDER BY SERVICE(url)) AS services
  FROM
    `httparchive.crawl.requests`
  WHERE
    date IN UNNEST(@dates) AND
    type = 'font' AND
    is_root_page
  GROUP BY
    date,
    client,
    page
),

services_2 AS (
  SELECT
    date,
    client,
    services,
    COUNT(DISTINCT page) AS count
  FROM
    services_1
  GROUP BY
    date,
    client,
    services
),

pages AS (
  SELECT
    date,
    client,
    COUNT(DISTINCT page) AS total
  FROM
    `httparchive.crawl.requests`
  WHERE
    date IN UNNEST(@dates) AND
    is_root_page
  GROUP BY
    date,
    client
)

SELECT
  date,
  client,
  services,
  count,
  total,
  ROUND(count / total, @precision) AS proportion
FROM
  services_2
JOIN
  pages
USING (date, client)
ORDER BY
  date,
  client,
  proportion DESC
