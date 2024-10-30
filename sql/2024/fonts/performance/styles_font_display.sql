-- Section: Performance
-- Question: What is the usage of font-display in CSS?
-- Normalization: Sites

CREATE TEMPORARY FUNCTION PROPERTIES(json STRING)
RETURNS ARRAY<STRING>
LANGUAGE js
OPTIONS(library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  const values = ['auto', 'block', 'fallback', 'optional', 'swap'];
  const $ = JSON.parse(json);
  const result = [];
  walkDeclarations($, (declaration) => {
    const value = declaration.value.toLowerCase();
    result.push(values.find((other) => value.includes(other)) || 'other');
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
properties AS (
  SELECT
    client,
    NULLIF(property, 'other') AS property,
    COUNT(DISTINCT page) AS count,
    ROW_NUMBER() OVER (PARTITION BY client ORDER BY COUNT(DISTINCT page) DESC) AS rank
  FROM
    `httparchive.all.parsed_css`,
    UNNEST(PROPERTIES(css)) AS property
  WHERE
    date = '2024-07-01' AND
    is_root_page
  GROUP BY
    client,
    property
  QUALIFY
    rank <= 10
),
sites AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS total
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND
    is_root_page
  GROUP BY
    client
)

SELECT
  client,
  property,
  count,
  total,
  count / total AS proportion
FROM
  properties
JOIN
  sites USING (client)
ORDER BY
  client,
  proportion DESC
