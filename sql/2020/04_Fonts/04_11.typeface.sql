#standardSQL
#typeface_by_country
CREATE TEMPORARY FUNCTION
  getFontFamilies(css STRING)
  RETURNS ARRAY<STRING>
  LANGUAGE js AS '''
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

WITH
  countries AS (
  SELECT
    *,
    'ad' AS country_code,
    'Andorra' AS country
  FROM
    `chrome-ux-report.country_ad.201808`
  UNION ALL
  SELECT
    *,
    'ae' AS country_code,
    'United Arab Emirates' AS country
  FROM
    `chrome-ux-report.country_ae.201808`
  UNION ALL
  SELECT
    *,
    'af' AS country_code,
    'Afghanistan' AS country
  FROM
    `chrome-ux-report.country_af.201808`
  UNION ALL
  SELECT
    *,
    'ag' AS country_code,
    'Antigua and Barbuda' AS country
  FROM
    `chrome-ux-report.country_ag.201808` )
SELECT
  client,
  country,
  font_family,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
FROM
  countries,
  `httparchive.almanac.parsed_css`,
  UNNEST(getFontFamilies(css)) AS font_family
WHERE
  CONCAT(origin, '/') = page
GROUP BY
  client,
  country,
  font_family
ORDER BY
  freq / total DESC