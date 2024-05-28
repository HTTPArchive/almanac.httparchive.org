CREATE TEMP FUNCTION hasGPOSKerning(data STRING) RETURNS BOOL LANGUAGE js AS '''
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
    (hasGPOSKerning(JSON_EXTRACT(payload, '$._font_details.features')) OR IFNULL(REGEXP_CONTAINS(JSON_EXTRACT(payload,
      '$._font_details.table_sizes'), '(?i)kern'), false)) AS kerning
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2022-06-01' AND
    type = 'font'
  GROUP BY
    client,
    url,
    kerning
)

SELECT
  client,
  kerning,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct_freq
FROM
  fonts
GROUP BY
  client,
  kerning
ORDER BY
  pct_freq DESC
