CREATE TEMPORARY FUNCTION countColorMixDeclarations(css JSON)
RETURNS NUMERIC
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS r'''
try {
  return countDeclarations(css.stylesheet.rules, {values: /color-mix\(.*\)/});
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
    `httparchive.crawl.parsed_css`
  WHERE
    date = '2025-07-01' AND
    rank <= 1000000
)
GROUP BY
  client
