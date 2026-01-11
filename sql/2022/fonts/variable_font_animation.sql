CREATE TEMPORARY FUNCTION animatesVariableFonts(css STRING)
RETURNS BOOLEAN
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  var ast = JSON.parse(css);
  let count = 0;

  walkRules(ast, rule => {
    rule.keyframes.forEach(f => {
      count += countDeclarations(f, { properties: 'font-variation-settings' });
    });
  }, { type: 'keyframes' });

  count += countDeclarations(ast.stylesheet.rules, {properties: 'transition', values: /font-variation-settings/})
  return count > 0;
} catch (e) {
  return false;
}
''';

SELECT
  client,
  COUNTIF(animates_variable_fonts > 0) AS animates_variable_fonts,
  COUNT(DISTINCT page) AS total,
  COUNTIF(animates_variable_fonts > 0) / COUNT(DISTINCT page) AS pct
FROM (
  SELECT
    client,
    page,
    COUNTIF(animatesVariableFonts(css)) AS animates_variable_fonts
  FROM
    `httparchive.almanac.parsed_css`
  WHERE date = '2022-07-01' -- noqa: CV09
  GROUP BY
    client,
    page
)
GROUP BY
  client
