-- Section: Performance
-- Question: Which file formats are used?
-- Normalization: Requests and fonts

-- INCLUDE https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/{year}/fonts/common.sql

WITH
requests AS (
  SELECT
    client,
    url,
    FILE_FORMAT(STRING(summary.ext), STRING(summary.mimeType)) AS format,
    COUNT(0) OVER (PARTITION BY client) AS total,
    COUNT(DISTINCT url) OVER (PARTITION BY client) AS total_secondary
  FROM
    `httparchive.crawl.requests`
  WHERE
    date = @date AND
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
  ROUND(COUNT(0) / total, @precision) AS proportion,
  ROUND(COUNT(DISTINCT url) / total_secondary, @precision) AS proportion_secondary,
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
