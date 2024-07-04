-- Section: Development
-- Question: What features are supported in fonts?

CREATE TEMPORARY FUNCTION FEATURES(data STRING)
RETURNS ARRAY<STRING>
LANGUAGE js
AS '''
try {
  const json = JSON.parse(data);
  const result = new Set();
  for (const [table, scripts] of Object.entries(json)) {
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
features AS (
  SELECT
    client,
    url,
    feature
  FROM
    `httparchive.all.requests`
    UNNEST(FEATURES(JSON_EXTRACT(payload, '$._font_details.features'))) AS feature
  WHERE
    date = '2024-06-01' AND
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
  features
GROUP BY
  client,
  feature
ORDER BY
  client,
  proportion DESC
