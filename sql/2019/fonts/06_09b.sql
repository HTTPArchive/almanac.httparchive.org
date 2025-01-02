#standardSQL
# 06_09b: Distribution of duplicate font-family values per page (see 02_35)
CREATE TEMPORARY FUNCTION getFonts(css STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var reduceValues = (values, rule) => {
    if ('rules' in rule) {
      return rule.rules.reduce(reduceValues, values);
    }
    if (!('declarations' in rule)) {
      return values;
    }
    if (rule.type != 'font-face') {
      return values;
    }
    return values.concat(rule.declarations.filter(d => d.property.toLowerCase() == 'font-family').map(d => d.value));
  };
  var $ = JSON.parse(css);
  return $.stylesheet.rules.reduce(reduceValues, []);
} catch (e) {
  return [];
}
''';

SELECT
  percentile,
  client,
  APPROX_QUANTILES(fonts, 1000)[OFFSET(percentile * 10)] AS font_families_per_page
FROM (
  SELECT
    client,
    page,
    COUNT(DISTINCT value) AS fonts
  FROM
    `httparchive.almanac.parsed_css`
  LEFT JOIN
    UNNEST(getFonts(css)) AS value
  WHERE
    date = '2019-07-01'
  GROUP BY
    client,
    page
),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
