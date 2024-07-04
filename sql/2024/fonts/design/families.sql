-- Section: Design
-- Question: Which families are popular?

CREATE TEMPORARY FUNCTION FAMILIES(css STRING)
RETURNS ARRAY<STRING>
LANGUAGE js
OPTIONS (library = ["gs://httparchive/lib/css-font-parser.js", "gs://httparchive/lib/css-utils.js"])
AS '''
try {
  const ast = JSON.parse(css);
  let result = [];

  walkDeclarations(ast, (decl) => {
    result.push(parseFontFamilyProperty(decl.value)[0]);
  }, {
    properties: 'font-family',
    rules: (r) =>  r.type === 'font-face'
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
families AS (
  SELECT
    client,
    family,
    COUNT(DISTINCT page) AS count
  FROM
    `httparchive.all.parsed_css`,
    UNNEST(FAMILIES(css)) AS family
  WHERE
    date = '2024-06-01'
  GROUP BY
    client,
    family
)

SELECT
  client,
  family,
  count,
  total,
  count / total AS proportion
FROM
  families
JOIN
  pages USING (client)
ORDER BY
  proportion DESC
