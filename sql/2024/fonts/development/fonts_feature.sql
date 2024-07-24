-- Section: Development
-- Question: Which features are used in fonts?

CREATE TEMPORARY FUNCTION FEATURES(data STRING)
RETURNS ARRAY<STRING>
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
    feature
  FROM
    `httparchive.all.requests`,
    UNNEST(FEATURES(JSON_EXTRACT(payload, '$._font_details.features'))) AS feature
  WHERE
    date = '2024-07-01' AND
    type = 'font'
  GROUP BY
    client,
    url,
    feature
)

SELECT
  client,
  feature,
  COUNT(0) AS count,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS proportion
FROM
  fonts
GROUP BY
  client,
  feature
ORDER BY
  client,
  proportion DESC
