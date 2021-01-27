#standardSQL
# 02_46: Distribution of selector class length
CREATE TEMPORARY FUNCTION getClassChainLengths(css STRING)
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
        selector.split(' ').forEach(descendent => {
          var chainLength = descendent.split('.').length - 1;
          values.push(chainLength);
        });
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
  APPROX_QUANTILES(classes, 1000)[OFFSET(100)] AS p10,
  APPROX_QUANTILES(classes, 1000)[OFFSET(250)] AS p25,
  APPROX_QUANTILES(classes, 1000)[OFFSET(500)] AS p50,
  APPROX_QUANTILES(classes, 1000)[OFFSET(750)] AS p75,
  APPROX_QUANTILES(classes, 1000)[OFFSET(900)] AS p90
FROM
  `httparchive.almanac.parsed_css`
LEFT JOIN
  UNNEST(getClassChainLengths(css)) AS classes
WHERE
  date = '2019-07-01'
GROUP BY
  client
