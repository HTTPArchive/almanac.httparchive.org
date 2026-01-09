-- Section: Development
-- Question: How popular are color fonts?
-- Normalization: Pages

-- INCLUDE https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/2024/fonts/common.sql

WITH
fonts AS (
  SELECT
    date,
    client,
    COUNT(DISTINCT page) AS count
  FROM
    `httparchive.all.requests`
  WHERE
    date IN ('2022-07-01', '2023-07-01', '2024-07-01') AND -- noqa: CV09
    type = 'font' AND
    is_root_page AND
    IS_COLOR(payload)
  GROUP BY
    date,
    client
),

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
  count,
  total,
  count / total AS proportion
FROM
  fonts
JOIN
  pages
USING (date, client)
ORDER BY
  date,
  proportion DESC
