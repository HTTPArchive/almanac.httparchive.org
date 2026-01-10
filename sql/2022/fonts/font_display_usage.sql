CREATE TEMPORARY FUNCTION getFontDisplay(json STRING)
RETURNS ARRAY<STRING>
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
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

SELECT
  client,
  font_display,
  pages,
  total,
  pages / total AS pct
FROM (
  SELECT
    client,
    font_display,
    COUNT(DISTINCT page) AS pages
  FROM
    `httparchive.almanac.parsed_css`,
    UNNEST(getFontDisplay(css)) AS font_display
  WHERE
    date = '2022-07-01' -- noqa: CV09
  GROUP BY
    client,
    font_display
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
