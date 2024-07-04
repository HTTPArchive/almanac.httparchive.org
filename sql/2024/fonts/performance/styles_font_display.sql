-- Section: Performance
-- Question: What is the usage of font-display in CSS?

CREATE TEMPORARY FUNCTION PROPERTIES(json STRING)
RETURNS ARRAY<STRING>
LANGUAGE js
OPTIONS(library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  const ast = JSON.parse(json);
  const result = [];
  walkDeclarations(ast, decl => {
    result.push(decl.value);
  }, {
    properties: 'font-display',
    rules: r => r.type === 'font-face'
  });

  return result;
} catch (e) {
  return [];
}
''';

WITH
pages AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS total
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-06-01'
  GROUP BY
    client
),
properties AS (
  SELECT
    client,
    property,
    COUNT(DISTINCT page) AS count
  FROM
    `httparchive.all.parsed_css`,
    UNNEST(PROPERTIES(css)) AS property
  WHERE
    date = '2024-06-01'
  GROUP BY
    client,
    property
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
  pages USING (client)
ORDER BY
  proportion DESC
