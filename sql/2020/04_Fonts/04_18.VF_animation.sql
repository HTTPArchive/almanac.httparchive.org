#standardSQL
# pages that animate variable font axes
CREATE TEMPORARY FUNCTION animatesVariableFonts(css STRING) RETURNS BOOLEAN LANGUAGE js AS '''
try {
  var ast = JSON.parse(css);  
  return countDeclarations(ast.stylesheet.rules, {properties: 'transition', values: /font-variation-settings/}) > 0;
} catch (e) {
  return false;
}
'''
OPTIONS (library="gs://httparchive/lib/css-utils.js");
SELECT
  client,
  COUNTIF(animates_variable_fonts > 0) AS animates_variable_fonts,
  COUNT(0) AS total,
  COUNTIF(animates_variable_fonts > 0) / COUNT(0) AS pct
FROM (
  SELECT
    client,
    page,
    COUNTIF(animatesVariableFonts(css)) AS animates_variable_fonts
  FROM
   `httparchive.almanac.parsed_css`
  GROUP BY
    client,
    page)
GROUP BY
  client