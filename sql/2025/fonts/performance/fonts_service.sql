-- Section: Performance
-- Question: Which services are popular?
-- Normalization: Pages

-- INCLUDE https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/2025/fonts/common.sql

WITH
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
  SERVICE(url) AS service,
  COUNT(DISTINCT page) AS count,
  total,
  COUNT(DISTINCT page) / total AS proportion
FROM
  `httparchive.crawl.requests`
INNER JOIN
  pages
USING (date, client)
WHERE
  date IN UNNEST(@dates) AND
  type = 'font' AND
  is_root_page
GROUP BY
  date,
  client,
  service,
  total
ORDER BY
  date,
  client,
  proportion DESC
