#standardSQL
#popular_typeface
CREATE TEMPORARY FUNCTION getFontFamilies(css STRING)
RETURNS ARRAY < STRING > LANGUAGE js AS '''
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
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  `httparchive.almanac.parsed_css`,
  UNNEST(getFontFamilies(css)) AS font_family
WHERE
  date="2020-08-01"
GROUP BY
  client,
  font_family
HAVING
  freq >= 1000 
ORDER BY
  client, pct DESC