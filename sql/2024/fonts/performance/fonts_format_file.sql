-- Section: Performance
-- Question: Which file formats are used?
-- Normalization: Requests and fonts

-- INCLUDE https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/2024/fonts/common.sql

WITH
requests AS (
  SELECT
    client,
    url,
    FILE_FORMAT(
      JSON_EXTRACT_SCALAR(summary, '$.ext'),
      JSON_EXTRACT_SCALAR(summary, '$.mimeType')
    ) AS format,
    COUNT(0) OVER (PARTITION BY client) AS total,
    COUNT(DISTINCT url) OVER (PARTITION BY client) AS total_secondary
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND -- noqa: CV09
    type = 'font' AND
    is_root_page
)

SELECT
  client,
  format,
  COUNT(0) AS count,
  COUNT(DISTINCT url) AS count_secondary,
  total,
  total_secondary,
  COUNT(0) / total AS proportion,
  COUNT(DISTINCT url) / total_secondary AS proportion_secondary,
  ROW_NUMBER() OVER (PARTITION BY client ORDER BY COUNT(0) DESC) AS rank
FROM
  requests
GROUP BY
  client,
  format,
  total,
  total_secondary
QUALIFY
  rank <= 10
ORDER BY
  client,
  proportion DESC
