-- Section: Development
-- Question: How prevalent is autohinting?
-- Normalization: Fonts (parsed only)

-- INCLUDE https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/2024/fonts/common.sql

CREATE TEMPORARY FUNCTION IS_HINTED(payload STRING) AS (
  REGEXP_CONTAINS(
    JSON_EXTRACT(payload, '$._font_details.table_sizes'),
    '(?i)fpgm|prep'
  )
);


CREATE TEMPORARY FUNCTION IS_AUTOHINTED(payload STRING) AS (
  REGEXP_CONTAINS(
    JSON_EXTRACT_SCALAR(payload, '$._font_details.names[5]'),
    'autohint'
  )
);

WITH
pages AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS total
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND -- noqa: CV09
    is_root_page
  GROUP BY
    client
)

SELECT
  client,
  IS_AUTOHINTED(payload) AS autohinted,
  COUNT(DISTINCT page) AS count,
  total,
  COUNT(DISTINCT page) / total AS proportion
FROM
  `httparchive.all.requests`
INNER JOIN
  pages
USING (client)
WHERE
  date = '2024-07-01' AND -- noqa: CV09
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
