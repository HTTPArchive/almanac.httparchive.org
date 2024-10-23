#standardSQL
#popular_typeface
CREATE TEMPORARY FUNCTION getFontFamilies(css STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var $ = JSON.parse(css);
  return $.stylesheet.rules.filter(rule => rule.type == 'font-face').map(rule => {
    var family = rule.declarations && rule.declarations.find(d => d.property == 'font-family');
    return family && family.value.replace(/[\'"]/g, '');
  }).filter(family => family);
} catch (e) {
  return [];
}
''';

SELECT
  client,
  font_family,
  pages,
  total,
  pages / total AS pct
FROM (
  SELECT
    client,
    font_family,
    COUNT(DISTINCT page) AS pages
  FROM
    `httparchive.almanac.parsed_css`,
    UNNEST(getFontFamilies(css)) AS font_family
  WHERE
    date = '2021-07-01'
  GROUP BY
    client,
    font_family
)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2021_07_01_*`
  GROUP BY
    client
)
USING (client)
WHERE
  pages / total >= 0.004
ORDER BY
  pct DESC
