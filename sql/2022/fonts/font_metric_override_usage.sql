CREATE TEMPORARY FUNCTION getFontMetricsOverride(json STRING)
RETURNS ARRAY<STRING> LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  const ast = JSON.parse(json);
  const result = [];
  walkDeclarations(ast, decl => {
    result.push(decl.property);
  }, {
    properties: ['size-adjust', 'ascent-override', 'descent-override', 'line-gap-override'],
    rules: r => r.type === 'font-face'
  });
  return result;
} catch (e) {
  return [];
}
''';

SELECT
  client,
  font_override,
  pages,
  total,
  pages / total AS pct
FROM (
  SELECT
    client,
    font_override,
    COUNT(DISTINCT page) AS pages
  FROM
    `httparchive.almanac.parsed_css`,
    UNNEST(getFontMetricsOverride(css)) AS font_override
  WHERE
    date = '2022-07-01' -- noqa: CV09
  GROUP BY
    client,
    font_override
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
