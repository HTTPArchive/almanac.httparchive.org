CREATE TEMPORARY FUNCTION countSubgridDeclarations(css STRING)
RETURNS NUMERIC
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  const ast = JSON.parse(css);
  return countDeclarations(ast.stylesheet.rules, {properties: /^grid-template-(rows|columns)$/, values: 'subgrid'});
} catch (e) {
  return null;
}
''';

SELECT
  client,
  COUNT(DISTINCT IF(declarations > 0, page, NULL)) AS pages,
  COUNT(DISTINCT page) AS total,
  COUNT(DISTINCT IF(declarations > 0, page, NULL)) / COUNT(DISTINCT page) AS pct_pages
FROM (
  SELECT
    client,
    page,
    countSubgridDeclarations(css) AS declarations
  FROM
    `httparchive.almanac.parsed_css`
  WHERE
    date = '2022-07-01' -- noqa: CV09
)
GROUP BY
  client
