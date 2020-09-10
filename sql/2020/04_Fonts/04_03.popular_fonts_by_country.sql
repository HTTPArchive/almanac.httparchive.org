#standardSQL
#typeface by country
CREATE TEMPORARY FUNCTION getFontFamilies(css STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var $ = JSON.parse(css);
  return $.stylesheet.rules.filter(rule => rule.type == 'font-face').map(rule => {
    var family = rule.declarations && rule.declarations.find(d => d.property == 'font-family');
    return family && family.value.replace(/['"]/g, '');
  }).filter(family => family);
} catch (e) {
  return [];
}
''';

SELECT
client,
country,
font_family, 
COUNT(0) AS freq_typeface,
SUM(COUNT(0)) OVER (PARTITION BY client) AS total_typeface,
ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct
FROM `httparchive.almanac.parsed_css`,
UNNEST(getFontFamilies(css)) AS font_family
join (SELECT DISTINCT origin,`chrome-ux-report`.experimental.GET_COUNTRY(country_code) AS country
FROM `chrome-ux-report.materialized.country_summary` WHERE yyyymm=202007)
ON CONCAT(origin, '/')=page
WHERE date='2020-08-01'
GROUP BY
client,
country,
font_family
ORDER BY
freq_typeface DES