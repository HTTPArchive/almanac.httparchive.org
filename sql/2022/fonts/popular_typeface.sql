CREATE TEMPORARY FUNCTION getFontFamilies(css STRING)
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
    UNNEST(getFontFamilies(css)) AS font_family
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
WHERE
  pages / total >= 0.004
ORDER BY
  pct DESC
