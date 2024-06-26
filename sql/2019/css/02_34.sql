#standardSQL
# 02_34: Distribution of fonts declared per page
CREATE TEMPORARY FUNCTION countFonts(css STRING)
RETURNS INT64 LANGUAGE js AS '''
try {
  var $ = JSON.parse(css);
  return $.stylesheet.rules.filter(rule => rule.type == 'font-face').length;
} catch (e) {
  return 0;
}
''';

SELECT
  client,
  APPROX_QUANTILES(font_rules, 1000)[OFFSET(100)] AS p10,
  APPROX_QUANTILES(font_rules, 1000)[OFFSET(250)] AS p25,
  APPROX_QUANTILES(font_rules, 1000)[OFFSET(500)] AS p50,
  APPROX_QUANTILES(font_rules, 1000)[OFFSET(750)] AS p75,
  APPROX_QUANTILES(font_rules, 1000)[OFFSET(900)] AS p90
FROM (
  SELECT
    client,
    SUM(countFonts(css)) AS font_rules
  FROM
    `httparchive.almanac.parsed_css`
  WHERE
    date = '2019-07-01'
  GROUP BY
    client,
    page
)
GROUP BY
  client
