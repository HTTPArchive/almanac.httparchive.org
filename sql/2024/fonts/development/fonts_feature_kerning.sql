-- Section: Development
-- Question: How prevalent is kerning support?
-- Normalization: Fonts (parsed only)

-- INCLUDE https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/2024/fonts/common.sql

CREATE TEMPORARY FUNCTION HAS_KERNING(data STRING)
RETURNS BOOL
LANGUAGE js
AS '''
try {
  const $ = JSON.parse(data);
  const result = new Set();
  for (const [table, scripts] of Object.entries($)) {
    for (const [script, languages] of Object.entries(scripts)) {
      for (const [language, features] of Object.entries(languages)) {
        features.forEach(feature => result.add(feature));
      }
    }
  }
  return Array.from(result).includes('kern');
} catch (e) {
  return false;
}
''';

WITH
fonts AS (
  SELECT
    date,
    client,
    url,
    (
      HAS_KERNING(JSON_EXTRACT(ANY_VALUE(payload), '$._font_details.features')) OR
      IFNULL(
        REGEXP_CONTAINS(
          JSON_EXTRACT(ANY_VALUE(payload), '$._font_details.table_sizes'),
          '(?i)kern'
        ),
        FALSE
      )
    ) AS support,
    COUNT(0) OVER (PARTITION BY date, client) AS total
  FROM
    `httparchive.all.requests`
  WHERE
    date IN ('2022-07-01', '2023-07-01', '2024-07-01') AND -- noqa: CV09
    type = 'font' AND
    is_root_page AND
    IS_PARSED(payload)
  GROUP BY
    date,
    client,
    url
)

SELECT
  date,
  client,
  support,
  COUNT(DISTINCT url) AS count,
  total,
  COUNT(DISTINCT url) / total AS proportion
FROM
  fonts
GROUP BY
  date,
  client,
  support,
  total
ORDER BY
  date,
  client,
  support
