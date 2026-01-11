-- Section: Design
-- Question: Which scripts does one design for?
-- Normalization: Fonts (parsed only)

-- INCLUDE https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/2024/fonts/common.sql

WITH
fonts AS (
  SELECT
    client,
    url,
    SCRIPTS(ANY_VALUE(payload)) AS scripts,
    COUNT(0) OVER (PARTITION BY client) AS total
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND -- noqa: CV09
    type = 'font' AND
    is_root_page AND
    IS_PARSED(payload)
  GROUP BY
    client,
    url
)

SELECT
  client,
  script,
  COUNT(DISTINCT url) AS count,
  total,
  COUNT(DISTINCT url) / total AS proportion
FROM
  fonts,
  UNNEST(scripts) AS script
GROUP BY
  client,
  script,
  total
ORDER BY
  client,
  proportion DESC
