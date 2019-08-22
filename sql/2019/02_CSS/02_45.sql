#standardSQL
# 02_45: Distribution of selector class length per page
CREATE TEMPORARY FUNCTION getAllValues(css STRING)
RETURNS ARRAY<INT64> LANGUAGE js AS '''
try {
  var reduceValues = (values, rule) => {
    if ('rules' in rule) {
      return rule.rules.reduce(reduceValues, values);
    }
    var selectors = rule.selectors || rule.selector && [rule.selector];
    if (!selectors) {
      return values;
    }

    rule.selectors.forEach(selector => {
      if (selector.includes('.')) {
        var classLength = selector.split('.').length - 1;
        values.push(classLength);
      }
    });
    return values;
  };
  var $ = JSON.parse(css);
  return $.stylesheet.rules.reduce(reduceValues, []);
} catch (e) {
  return [];
}
''';

SELECT
  client,
  APPROX_QUANTILES(keyframes, 1000)[OFFSET(100)] AS p10,
  APPROX_QUANTILES(keyframes, 1000)[OFFSET(250)] AS p25,
  APPROX_QUANTILES(keyframes, 1000)[OFFSET(500)] AS p50,
  APPROX_QUANTILES(keyframes, 1000)[OFFSET(750)] AS p75,
  APPROX_QUANTILES(keyframes, 1000)[OFFSET(900)] AS p90
FROM (
  SELECT
    client,
    COUNT(DISTINCT value) AS keyframes
  FROM
    `httparchive.almanac.parsed_css`
  LEFT JOIN
    UNNEST(getAllValues(css)) AS value
  GROUP BY
    client,
    page)
GROUP BY
  client