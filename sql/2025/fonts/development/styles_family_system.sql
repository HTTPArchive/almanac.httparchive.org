-- Section: Development
-- Question: Which system families are popular?
-- Normalization: Pages

CREATE TEMPORARY FUNCTION FAMILIES(json STRING)
RETURNS ARRAY<STRING>
LANGUAGE js
OPTIONS (library = ["gs://httparchive/lib/css-font-parser.js", "gs://httparchive/lib/css-utils.js"])
AS '''
const system = [
  'cursive',
  'emoji',
  'fangsong',
  'fantasy',
  'math',
  'monospace',
  'sans-serif',
  'serif',
  'system-ui',
  'ui-monospace',
  'ui-rounded',
  'ui-sans-serif',
  'ui-serif'
];

try {
  const $ = JSON.parse(json);
  const result = [];
  walkDeclarations($, (declaration) => {
    if (declaration.property.toLowerCase() === 'font-family') {
      const fonts = parseFontFamilyProperty(declaration.value);
      if (fonts) {
        fonts.forEach(font => result.push(font));
      }
    } else if (declaration.property.toLowerCase() === 'font') {
      const value = parseFontProperty(declaration.value);
      if (value) {
        value['font-family'].forEach((font) => result.push(font));
      }
    }
  }, {
    properties: ['font-family', 'font'],
    rules: (rule) => rule.type.toLowerCase() !== 'font-face'
  });
  return result.filter((font) => system.includes(font));
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
    `httparchive.crawl.parsed_css`,
    UNNEST(FAMILIES(css)) AS family
  WHERE
    date = @date AND
    is_root_page
  GROUP BY
    client,
    family
),

pages AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS total
  FROM
    `httparchive.crawl.requests`
  WHERE
    date = @date AND
    is_root_page
  GROUP BY
    client
)

SELECT
  client,
  family,
  count,
  total,
  ROUND(count / total, @precision) AS proportion
FROM
  families
JOIN
  pages
USING (client)
ORDER BY
  client,
  count DESC
