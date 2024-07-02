CREATE TEMP FUNCTION getFeatures(data STRING) RETURNS ARRAY<STRING> LANGUAGE js AS '''
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
fonts AS (
  SELECT
    client,
    url,
    payload
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2022-06-01' AND
    type = 'font'
  GROUP BY
    client,
    url,
    payload
)

SELECT
  client,
  feature,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct_freq
FROM
  fonts,
  UNNEST(getFeatures(JSON_EXTRACT(payload, '$._font_details.features'))) AS feature
GROUP BY
  client,
  feature
ORDER BY
  pct_freq DESC
