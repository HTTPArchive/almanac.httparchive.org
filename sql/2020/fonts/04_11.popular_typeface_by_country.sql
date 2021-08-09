#standardSQL
#popular typeface by country
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
  country,
  font_family,
  freq,
  total,
  pct
FROM (
  SELECT
    client,
    country,
    font_family,
    COUNT(0) AS freq,
    SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
    COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct,
    ROW_NUMBER() OVER (PARTITION BY client, country ORDER BY COUNT(0) DESC) AS sort_row
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
      yyyymm = 202008)
  ON
    CONCAT(origin, '/') = page AND
    IF(device = 'desktop', 'desktop', 'mobile') = client
  WHERE
    date = '2020-08-01'
  GROUP BY
    client,
    country,
    font_family
  ORDER BY
    client, country, freq DESC)
WHERE
  sort_row <= 1
