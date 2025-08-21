-- Section: Development
-- Question: How prevalent is autohinting?
-- Normalization: Fonts (parsed only)

-- INCLUDE https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/{year}/fonts/common.sql

CREATE TEMPORARY FUNCTION IS_HINTED(payload JSON) AS (
  REGEXP_CONTAINS(
    TO_JSON_STRING(payload._font_details.table_sizes),
    '(?i)fpgm|prep'
  )
);


CREATE TEMPORARY FUNCTION IS_AUTOHINTED(payload JSON) AS (
  REGEXP_CONTAINS(STRING(payload._font_details.names[5]), 'autohint')
);

WITH
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
  IS_AUTOHINTED(payload) AS autohinted,
  COUNT(DISTINCT page) AS count,
  total,
  ROUND(COUNT(DISTINCT page) / total, @precision) AS proportion
FROM
  `httparchive.crawl.requests`
INNER JOIN
  pages
USING (client)
WHERE
  date = @date AND
  type = 'font' AND
  is_root_page AND
  IS_PARSED(payload) AND
  IS_HINTED(payload)
GROUP BY
  client,
  autohinted,
  total
ORDER BY
  client,
  autohinted
