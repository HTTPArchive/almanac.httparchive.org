#standardSQL
# 02_41: Distribution of transitions per page
CREATE TEMPORARY FUNCTION getTransitions(css STRING)
RETURNS INT64 LANGUAGE js AS '''
try {
  var reduceValues = (values, rule) => {
    if ('rules' in rule) {
      return rule.rules.reduce(reduceValues, values);
    }
    if (!('declarations' in rule)) {
      return values;
    }

    return values + !!rule.declarations.find(d => d.property.toLowerCase().startsWith('transition'));
  };
  var $ = JSON.parse(css);
  return $.stylesheet.rules.reduce(reduceValues, 0);
} catch (e) {
  return 0;
}
''';

SELECT
  client,
  APPROX_QUANTILES(transitions, 1000)[OFFSET(100)] AS p10,
  APPROX_QUANTILES(transitions, 1000)[OFFSET(250)] AS p25,
  APPROX_QUANTILES(transitions, 1000)[OFFSET(500)] AS p50,
  APPROX_QUANTILES(transitions, 1000)[OFFSET(750)] AS p75,
  APPROX_QUANTILES(transitions, 1000)[OFFSET(900)] AS p90
FROM (
  SELECT
    client,
    SUM(getTransitions(css)) AS transitions
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
