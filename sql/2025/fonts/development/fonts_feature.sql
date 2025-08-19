-- Section: Development
-- Question: Which features are used in fonts?
-- Normalization: Fonts (parsed only)

-- INCLUDE https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/{year}/fonts/common.sql

CREATE TEMPORARY FUNCTION FEATURES(features JSON)
RETURNS ARRAY<STRING>
LANGUAGE js
AS '''
try {
  const result = new Set();
  for (const [table, scripts] of Object.entries(features)) {
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
    FEATURES(ANY_VALUE(payload)._font_details.features) AS features,
    COUNT(0) OVER (PARTITION BY client) AS total
  FROM
    `httparchive.crawl.requests`
  WHERE
    date = @date AND
    type = 'font' AND
    is_root_page AND
    IS_PARSED(payload)
  GROUP BY
    client,
    url
)

SELECT
  client,
  feature,
  COUNT(0) AS count,
  total,
  ROUND(COUNT(0) / total, @precision) AS proportion,
  ROW_NUMBER() OVER (PARTITION BY client ORDER BY COUNT(0) DESC) AS rank
FROM
  fonts,
  UNNEST(features) AS feature
GROUP BY
  client,
  feature,
  total
QUALIFY
  rank <= 100
ORDER BY
  client,
  count DESC
