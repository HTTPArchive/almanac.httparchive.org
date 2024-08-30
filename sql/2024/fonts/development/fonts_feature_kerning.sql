-- Section: Development
-- Question: How prevalent is kerning support?
-- Normalization: Fonts

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
    client,
    url,
    (
      HAS_KERNING(JSON_EXTRACT(payload, '$._font_details.features')) OR
      IFNULL(REGEXP_CONTAINS(JSON_EXTRACT(payload, '$._font_details.table_sizes'), '(?i)kern'), FALSE)
    ) AS support
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND
    type = 'font'
  GROUP BY
    client,
    url,
    support
)

SELECT
  client,
  support,
  COUNT(DISTINCT url) AS count,
  SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS total,
  COUNT(DISTINCT url) / SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS proportion
FROM
  fonts
GROUP BY
  client,
  support
ORDER BY
  client,
  support,
  proportion DESC
