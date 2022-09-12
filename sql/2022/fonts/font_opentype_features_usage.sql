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
SELECT
  feature,
  COUNT(0) AS freq,
  COUNT(0) / SUM(COUNT(0)) OVER () AS pct_freq
FROM
  `httparchive.almanac.requests`,
  UNNEST(getFeatures(JSON_EXTRACT(payload, '$._font_details.features'))) AS feature
WHERE
  date = '2022-06-01' AND
  type = 'font'
GROUP BY
  feature
ORDER BY
  pct_freq DESC
