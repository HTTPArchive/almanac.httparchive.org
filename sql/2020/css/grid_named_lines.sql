#standardSQL
CREATE TEMPORARY FUNCTION hasGridNamedLines(css STRING)
RETURNS BOOLEAN
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  const ast = JSON.parse(css);
  let props = countDeclarationsByProperty(ast.stylesheet.rules, {properties: /^grid($|\\-)/, values: /\\[([\\w-]+)\\]/});
  return Object.keys(props).length > 0;
} catch (e) {
  return false;
}
''';

SELECT
  client,
  COUNTIF(grid_named_lines) AS pages_with_grid_named_lines,
  total,
  COUNTIF(grid_named_lines) / total AS pct
FROM (
  SELECT
    client,
    page,
    COUNTIF(hasGridNamedLines(css)) > 0 AS grid_named_lines
  FROM
    `httparchive.almanac.parsed_css`
  WHERE
    date = '2020-08-01'
  GROUP BY
    client,
    page
)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2020_08_01_*`
  GROUP BY
    client
)
USING (client)
GROUP BY
  client,
  total
