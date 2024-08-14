-- Section: Performance
-- Question: What is the usage of font-display in CSS?

CREATE TEMPORARY FUNCTION PROPERTIES(json STRING)
RETURNS ARRAY<STRING>
LANGUAGE js
OPTIONS(library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  const $ = JSON.parse(json);
  const result = [];
  walkDeclarations($, (declaration) => {
    result.push(declaration.value);
  }, {
    properties: 'font-display',
    rules: (rule) => rule.type.toLowerCase() === 'font-face'
  });
  return result;
} catch (e) {
  return [];
}
''';

WITH
pages AS (
  SELECT
    date,
    client,
    COUNT(DISTINCT page) AS total
  FROM
    `httparchive.all.requests`
  WHERE
    date IN ('2022-07-01', '2023-07-01', '2024-07-01')
  GROUP BY
    date,
    client
),
properties AS (
  SELECT
    date,
    client,
    property,
    COUNT(DISTINCT page) AS count
  FROM
    `httparchive.all.parsed_css`,
    UNNEST(PROPERTIES(css)) AS property
  WHERE
    date IN ('2022-07-01', '2023-07-01', '2024-07-01')
  GROUP BY
    date,
    client,
    property
)

SELECT
  date,
  client,
  property,
  count,
  total,
  count / total AS proportion
FROM
  properties
JOIN
  pages USING (date, client)
ORDER BY
  date,
  client,
  proportion DESC
