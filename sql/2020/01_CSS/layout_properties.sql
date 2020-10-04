#standardSQL
# Float styles
CREATE TEMPORARY FUNCTION getLayoutUsage(css STRING)
RETURNS STRUCT<display NUMERIC, position NUMERIC, float NUMERIC> LANGUAGE js AS '''
try {
  const ast = JSON.parse(css);
  return countDeclarationsByProperty(ast.stylesheet.rules, {properties: [/^float$/, /^display$/, /^position$/]})
} catch (e) {
  return {
    display: 0,
    position: 0,
    float: 0
  };
}
'''
OPTIONS (library="gs://httparchive/lib/css-utils.js");

SELECT
  client,
  COUNTIF(display > 0) AS freq_display,
  COUNTIF(position > 0) AS freq_position,
  COUNTIF(float > 0) AS freq_float,
  COUNT(0) AS total,
  COUNTIF(display > 0) / COUNT(0) AS pct_display,
  COUNTIF(position > 0) / COUNT(0) AS pct_position,
  COUNTIF(float > 0) / COUNT(0) AS pct_float
FROM (
  SELECT
    client,
    SUM(layout.display) AS display,
    SUM(layout.position) AS position,
    SUM(layout.float) AS float
  FROM (
    SELECT
      client,
      page,
      getLayoutUsage(css) AS layout
    FROM
      `httparchive.almanac.parsed_css`
    WHERE
      date = '2020-08-01')
  GROUP BY
    client,
    page)
GROUP BY
  client