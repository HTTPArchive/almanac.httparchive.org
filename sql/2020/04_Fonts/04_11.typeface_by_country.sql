#standardSQL
#typeface by country
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
  country,
  freq_typeface,
  total_typeface,
  pct
FROM (
  SELECT
    client,
    font_family,
    country,
    COUNT(DISTINCT page) AS freq_typeface,
    SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client) AS total_typeface,
    COUNT(DISTINCT page) / SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client) AS pct,
  FROM
    `httparchive.almanac.parsed_css`,
    UNNEST(getFontFamilies(css)) AS font_family
  JOIN (
    SELECT DISTINCT  
      origin, device,
      `chrome-ux-report`.experimental.GET_COUNTRY(country_code) AS country
    FROM
      `chrome-ux-report.materialized.country_summary`
    WHERE
      yyyymm=202008)
  ON
    CONCAT(origin, '/')=page AND
    IF(device='desktop','desktop','mobile')=client
  WHERE
    date='2020-08-01'
    AND (country='Korea, Republic of' OR country='Iran (Islamic Republic of)' OR country='Turkey' OR country='Slovenia' OR country='Australia' OR country='Greece' OR country='United States of America' OR country='China' OR country='British Indian Ocean Territory' OR country='Eritrea' OR country='Falkland Islands (Malvinas)' OR country='Saint Helena, Ascension and Tristan da Cunha' OR country='Macaoa' OR country='Japan' OR country='China') 
  GROUP BY
    client,
    font_family,
    country
  ORDER BY
    client, font_family, freq_typeface DESC)