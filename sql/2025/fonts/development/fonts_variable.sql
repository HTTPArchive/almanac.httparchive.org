-- Section: Development
-- Question: How popular are variable fonts?
-- Normalization: Pages

-- INCLUDE https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/{year}/fonts/common.sql

WITH
fonts AS (
  SELECT
    date,
    client,
    COUNT(DISTINCT page) AS count
  FROM
    `httparchive.crawl.requests`
  WHERE
    date IN UNNEST(@dates) AND
    type = 'font' AND
    is_root_page AND
    IS_VARIABLE(payload)
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
  count,
  total,
  ROUND(count / total, @precision) AS proportion
FROM
  fonts
JOIN
  pages
USING (date, client)
ORDER BY
  date,
  client,
  count DESC
