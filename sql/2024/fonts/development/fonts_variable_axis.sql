-- Section: Development
-- Question: Which axes are used in variable fonts?
-- Normalization: Fonts (variable only)

-- INCLUDE https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/2024/fonts/common.sql

CREATE TEMPORARY FUNCTION AXES(json STRING)
RETURNS ARRAY<STRING>
LANGUAGE js
AS '''
try {
  return Object.keys(JSON.parse(json));
} catch (e) {
  return [];
}
''';

WITH
fonts AS (
  SELECT
    client,
    url,
    AXES(JSON_EXTRACT(ANY_VALUE(payload), '$._font_details.fvar')) AS axes,
    COUNT(0) OVER (PARTITION BY client) AS total
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND -- noqa: CV09
    type = 'font' AND
    is_root_page AND
    IS_VARIABLE(payload)
  GROUP BY
    client,
    url
)

SELECT
  client,
  axis,
  COUNT(0) AS count,
  total,
  COUNT(0) / total AS proportion
FROM
  fonts,
  UNNEST(axes) AS axis
GROUP BY
  client,
  axis,
  total
ORDER BY
  client,
  proportion DESC
