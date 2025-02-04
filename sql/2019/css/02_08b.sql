#standardSQL
# 02_08b: % of selectors that use classes or IDs
CREATE TEMPORARY FUNCTION getSelectorType(css STRING)
RETURNS STRUCT<class INT64, id INT64, total INT64> LANGUAGE js AS '''
var types = {
  'class': 0,
  'id': 0,
  'total': 0
};
try {
  var reduceValues = (values, rule) => {
    if ('rules' in rule) {
      return rule.rules.reduce(reduceValues, values);
    }
    var selectors = rule.selectors || rule.selector && [rule.selector];
    if (!selectors) {
      return values;
    }

    selectors.forEach(selector => {
      if (selector.includes('.')) {
        values.class++;
      }
      if (selector.includes(`#`)) {
        values.id++;
      }
      values.total++;
    });
    return values;
  };
  var $ = JSON.parse(css);
  return $.stylesheet.rules.reduce(reduceValues, types);
} catch (e) {
  return types;
}
''';

SELECT
  client,
  SUM(type.class) AS class,
  SUM(type.id) AS id,
  SUM(type.total) AS selectors,
  ROUND(SUM(type.class) * 100 / SUM(type.total), 2) AS pct_class,
  ROUND(SUM(type.id) * 100 / SUM(type.total), 2) AS pct_id
FROM (
  SELECT
    client,
    getSelectorType(css) AS type
  FROM
    `httparchive.almanac.parsed_css`
  WHERE
    date = '2019-07-01'
)
GROUP BY
  client
