-- Section: Development
-- Question: What is the distribution of color palettes?
-- Normalization: Fonts (color only)

-- INCLUDE https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/2024/fonts/common.sql

CREATE TEMPORARY FUNCTION COLORS(json STRING)
RETURNS ARRAY<STRING>
LANGUAGE js
AS '''
function toHex(value) {
  return ('0' + (value & 0xFF).toString(16)).slice(-2);
}

try {
  const $ = JSON.parse(json);
  const result = new Set();
  for (const palette of $) {
    for (const [blue, green, red, alpha] of palette) {
      result.add(`#${toHex(red)}${toHex(green)}${toHex(blue)}${toHex(alpha)}`);
    }
  }
  return Array.from(result);
} catch (e) {
  return [];
}
''';

WITH
fonts AS (
  SELECT
    client,
    url,
    COLORS(JSON_EXTRACT(ANY_VALUE(payload), '$._font_details.color.palettes')) AS colors,
    COUNT(0) OVER (PARTITION BY client) AS total
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND -- noqa: CV09
    type = 'font' AND
    is_root_page AND
    IS_COLOR(payload)
  GROUP BY
    client,
    url
)

SELECT
  client,
  color,
  COUNT(0) AS count,
  total,
  COUNT(0) / total AS proportion
FROM
  fonts,
  UNNEST(colors) AS color
GROUP BY
  client,
  color,
  total
ORDER BY
  client,
  proportion DESC
