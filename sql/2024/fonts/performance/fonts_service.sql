-- Section: Performance
-- Question: Which services are popular?
-- Normalization: Pages

-- INCLUDE https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/2024/fonts/common.sql

WITH
pages AS (
  SELECT
    date,
    client,
    COUNT(DISTINCT page) AS total
  FROM
    `httparchive.all.requests`
  WHERE
    date IN ('2022-07-01', '2023-07-01', '2024-07-01') AND -- noqa: CV09
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
  `httparchive.all.requests`
INNER JOIN
  pages
USING (date, client)
WHERE
  date IN ('2022-07-01', '2023-07-01', '2024-07-01') AND -- noqa: CV09
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
