-- Section: Development
-- Question: Which axes are used in variable fonts?

CREATE TEMPORARY FUNCTION AXES(js STRING)
RETURNS ARRAY<STRING>
LANGUAGE js
AS '''
try {
  return Object.keys(JSON.parse(js));
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
    date = '2024-06-01' AND
    type = 'font'
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
