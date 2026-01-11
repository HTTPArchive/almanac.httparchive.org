CREATE TEMPORARY FUNCTION getSystemFamilies(json STRING)
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

SELECT
  client,
  font_family,
  pages,
  total,
  pages / total AS pct
FROM (
  SELECT
    client,
    font_family,
    COUNT(DISTINCT page) AS pages
  FROM
    `httparchive.almanac.parsed_css`,
    UNNEST(getSystemFamilies(css)) AS font_family
  WHERE
    date = '2022-07-01' -- noqa: CV09
  GROUP BY
    client,
    font_family
)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2022_07_01_*` -- noqa: CV09
  GROUP BY
    client
)
USING (client)
ORDER BY
  pct DESC
