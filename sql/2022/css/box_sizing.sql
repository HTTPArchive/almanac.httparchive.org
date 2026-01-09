#standardSQL
# 1. Distribution of the number of occurrences of box-sizing:border-box per page.
# 2. Percent of pages with that style.
CREATE TEMPORARY FUNCTION countBorderBoxDeclarations(css STRING)
RETURNS NUMERIC
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS r'''
try {
  const ast = JSON.parse(css);
  return countDeclarations(ast.stylesheet.rules, {properties: /^(-(o|moz|webkit|ms)-)?box-sizing$/, values: 'border-box'});
} catch (e) {
  return null;
}
''';

SELECT
  percentile,
  client,
  COUNTIF(declarations > 0) AS pages,
  COUNT(0) AS total,
  COUNTIF(declarations > 0) / COUNT(0) AS pct_pages,
  APPROX_QUANTILES(declarations, 1000 IGNORE NULLS)[OFFSET(percentile * 10)] AS declarations_per_page
FROM (
  SELECT
    client,
    page,
    SUM(countBorderBoxDeclarations(css)) AS declarations
  FROM
    `httparchive.almanac.parsed_css`
  WHERE
    date = '2022-07-01' -- noqa: CV09
  GROUP BY
    client,
    page
),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
