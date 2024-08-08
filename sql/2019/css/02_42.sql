#standardSQL
# 02_42: Distribution of keyframes per page
CREATE TEMPORARY FUNCTION getKeyframes(css STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var $ = JSON.parse(css);
  return $.stylesheet.rules.reduce((values, rule) => {
    if (rule.type == 'keyframes') {
      values.push(rule.name);
    }
    return values;
  }, []);
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
    UNNEST(getKeyframes(css)) AS value
  WHERE
    date = '2019-07-01'
  GROUP BY
    client,
    page
)
GROUP BY
  client
