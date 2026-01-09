CREATE TEMPORARY FUNCTION countColorMixDeclarations(css STRING)
RETURNS NUMERIC
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS r'''
try {
  const ast = JSON.parse(css);
  return countDeclarations(ast.stylesheet.rules, {values: /color-mix\(.*\)/});
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
    countColorMixDeclarations(css) AS declarations
  FROM
    `httparchive.almanac.parsed_css`
  WHERE
    date = '2022-07-01' -- noqa: CV09
)
GROUP BY
  client
