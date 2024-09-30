-- Section: Development
-- Question: Which axes are used in variable fonts?
-- Normalization: Fonts

CREATE TEMPORARY FUNCTION AXES(json STRING)
RETURNS ARRAY<STRING>
LANGUAGE js
AS '''
try {
  return Object.keys(JSON.parse(json));
} catch (e) {
  return [];
}
''';

WITH
fonts AS (
  SELECT
    client,
    url,
    axis
  FROM
    `httparchive.all.requests`,
    UNNEST(AXES(JSON_EXTRACT(payload, '$._font_details.fvar'))) AS axis
  WHERE
    date = '2024-07-01' AND
    type = 'font'
    is_root_page AND
  GROUP BY
    client,
    url,
    axis
)

SELECT
  client,
  axis,
  COUNT(0) AS count,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS proportion
FROM
  fonts
GROUP BY
  client,
  axis
ORDER BY
  client,
  proportion DESC
