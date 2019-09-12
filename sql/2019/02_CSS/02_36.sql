#standardSQL
# 02_36: Distribution of unqiue font-size values per page
CREATE TEMPORARY FUNCTION getFontSizes(css STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var reduceValues = (values, rule) => {
    if ('rules' in rule) {
      return rule.rules.reduce(reduceValues, values);
    }
    if (!('declarations' in rule)) {
      return values;
    }

    return values.concat(rule.declarations.filter(d => d.property.toLowerCase() == 'font-size').map(d => d.value));
  };
  var $ = JSON.parse(css);
  return $.stylesheet.rules.reduce(reduceValues, []);
} catch (e) {
  return [];
}
''';

SELECT
  client,
  APPROX_QUANTILES(sizes, 1000)[OFFSET(100)] AS p10,
  APPROX_QUANTILES(sizes, 1000)[OFFSET(250)] AS p25,
  APPROX_QUANTILES(sizes, 1000)[OFFSET(500)] AS p50,
  APPROX_QUANTILES(sizes, 1000)[OFFSET(750)] AS p75,
  APPROX_QUANTILES(sizes, 1000)[OFFSET(900)] AS p90
FROM (
  SELECT
    client,
    COUNT(DISTINCT value) AS sizes
  FROM
    `httparchive.almanac.parsed_css`
  LEFT JOIN
    UNNEST(getFontSizes(css)) AS value
  GROUP BY
    client,
    page)
GROUP BY
  client