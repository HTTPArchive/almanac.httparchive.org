#standardSQL
# 1. Distribution of the number of occurrences of box-sizing:border-box per page.
# 2. Percent of pages with that style.
CREATE TEMPORARY FUNCTION countBorderBoxDeclarations(css STRING)
RETURNS NUMERIC
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
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
  COUNT(DISTINCT IF(declarations > 0, page, NULL)) AS pages,
  COUNT(DISTINCT page) AS total,
  COUNT(DISTINCT IF(declarations > 0, page, NULL)) / COUNT(DISTINCT page) AS pct_pages,
  APPROX_QUANTILES(declarations, 1000 IGNORE NULLS)[OFFSET(percentile * 10)] AS declarations_per_page
FROM (
  SELECT
    client,
    page,
    countBorderBoxDeclarations(css) AS declarations
  FROM
    `httparchive.almanac.parsed_css`
  WHERE
    date = '2020-08-01'),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
