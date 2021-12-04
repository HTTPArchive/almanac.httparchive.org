#standardSQL
CREATE TEMPORARY FUNCTION hasGridlikeFlexbox(css STRING)
RETURNS BOOLEAN
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  const ast = JSON.parse(css);
  return walkRules(ast, rule => {
    let d = Object.fromEntries(rule.declarations.map(d => [d.property, d.value]));

    if (d["flex-grow"] === "0" && d["flex-shrink"] === "0" || /^0 0($|\\s)/.test(d.flex)) {
      if (/%$/.test(d["flex-basis"]) || /%$/.test(d.flex) || /%$/.test(d.width) && (!d["flex-basis"] || d["flex-basis"] === "auto")) {
        return true; // break
      }
    }
  }, {type: "rule"}) || false;
} catch (e) {
  return false;
}
''';

SELECT
  client,
  COUNTIF(gridlike_flexbox) AS pages_with_gridlike_flexbox,
  total,
  COUNTIF(gridlike_flexbox) / total AS pct
FROM (
  SELECT
    client,
    page,
    COUNTIF(hasGridlikeFlexbox(css)) > 0 AS gridlike_flexbox
  FROM
    `httparchive.almanac.parsed_css`
  WHERE
    date = '2021-07-01'
  GROUP BY
    client,
    page)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2021_07_01_*`
  GROUP BY
    client)
USING
  (client)
GROUP BY
  client,
  total
