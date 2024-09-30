-- Section: Development
-- Question: What is the distribution of color palettes?
-- Normalization: Fonts

-- INCLUDE ../common.sql

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

SELECT
  client,
  color,
  COUNT(DISTINCT url) AS count,
  SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS total,
  COUNT(DISTINCT url) / SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS proportion
FROM
  `httparchive.all.requests`,
  UNNEST(COLORS(JSON_EXTRACT(payload, '$._font_details.color.palettes'))) AS color
WHERE
  date = '2024-07-01' AND
  type = 'font' AND
  is_root_page AND
  IS_COLOR(payload)
GROUP BY
  client,
  color
ORDER BY
  client,
  proportion DESC
