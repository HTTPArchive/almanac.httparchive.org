-- Section: Design
-- Question: Which system families are popular?

CREATE TEMPORARY FUNCTION FAMILIES(json STRING)
RETURNS ARRAY<STRING>
LANGUAGE js
OPTIONS (library = ["gs://httparchive/lib/css-font-parser.js", "gs://httparchive/lib/css-utils.js"])
AS '''
const system = [
  'serif',
  'sans-serif',
  'cursive',
  'fantasy',
  'monospace',
  'system-ui',
  'emoji',
  'math',
  'fangsong',
  'ui-serif',
  'ui-sans-serif',
  'ui-monospace',
  'ui-rounded'
];

try {
  const ast = JSON.parse(json);
  const result = [];

  walkDeclarations(ast, decl => {
    if (decl.property === 'font-family') {
      const fonts = parseFontFamilyProperty(decl.value);

      if (fonts) {
        fonts.forEach(font => result.push(font));
      }
    } else if (decl.property === 'font') {
      const value = parseFontProperty(decl.value);

      if (value) {
        value['font-family'].forEach(font => result.push(font));
      }
    }
  }, {
    properties: ['font-family', 'font'],
    rules: (r) => r.type !== 'font-face'
  });

  return result.filter(font => system.includes(font));
} catch (e) {
  return [];
}
''';

WITH
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
),
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
