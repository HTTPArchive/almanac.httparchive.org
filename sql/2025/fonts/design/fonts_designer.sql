-- Section: Design
-- Question: Which designers are popular?
-- Normalization: Pages

-- INCLUDE https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/{year}/fonts/common.sql

WITH
designers AS (
  SELECT
    client,
    NULLIF(TRIM(STRING(JSON_QUERY(payload, '$._font_details.names[9]'))), '') AS designer,
    COUNT(DISTINCT page) AS count,
    ROW_NUMBER() OVER (PARTITION BY client ORDER BY COUNT(DISTINCT page) DESC) AS rank
  FROM
    `httparchive.crawl.requests`
  WHERE
    date = @date AND
    type = 'font' AND
    is_root_page AND
    IS_PARSED(payload)
  GROUP BY
    client,
    designer
  QUALIFY
    rank <= 100
),

pages AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS total
  FROM
    `httparchive.crawl.requests`
  WHERE
    date = @date AND
    is_root_page
  GROUP BY
    client
)

SELECT
  client,
  designer,
  count,
  total,
  ROUND(count / total, @precision) AS proportion
FROM
  designers
JOIN
  pages
USING (client)
ORDER BY
  client,
  proportion DESC
