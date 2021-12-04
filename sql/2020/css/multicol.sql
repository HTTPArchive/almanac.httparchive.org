#standardSQL
CREATE TEMPORARY FUNCTION hasMulticol(css STRING)
RETURNS BOOLEAN
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  const ast = JSON.parse(css);
  let props = countDeclarationsByProperty(ast.stylesheet.rules, {properties: /^column[s-]/});
  return Object.keys(props).length > 0;
} catch (e) {
  return false;
}
''';

SELECT
  client,
  COUNTIF(multicol) AS pages_with_multicol,
  total,
  COUNTIF(multicol) / total AS pct
FROM (
  SELECT
    client,
    page,
    COUNTIF(hasMulticol(css)) > 0 AS multicol
  FROM
    `httparchive.almanac.parsed_css`
  WHERE
    date = '2020-08-01'
  GROUP BY
    client,
    page)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2020_08_01_*`
  GROUP BY
    client)
USING
  (client)
GROUP BY
  client,
  total
