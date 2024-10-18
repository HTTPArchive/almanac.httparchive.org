#standardSQL
# 02_35: Distribution of duplicate font-family values per page
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

    return values.concat(rule.declarations.filter(d => d.property.toLowerCase() == 'font-family').map(d => d.value));
  };
  var $ = JSON.parse(css);
  return $.stylesheet.rules.reduce(reduceValues, []);
} catch (e) {
  return [];
}
''';

SELECT
  client,
  APPROX_QUANTILES(duplicate_fonts, 1000)[OFFSET(100)] AS p10,
  APPROX_QUANTILES(duplicate_fonts, 1000)[OFFSET(250)] AS p25,
  APPROX_QUANTILES(duplicate_fonts, 1000)[OFFSET(500)] AS p50,
  APPROX_QUANTILES(duplicate_fonts, 1000)[OFFSET(750)] AS p75,
  APPROX_QUANTILES(duplicate_fonts, 1000)[OFFSET(900)] AS p90
FROM (
  SELECT
    client,
    page,
    COUNTIF(freq > 1) AS duplicate_fonts
  FROM (
    SELECT
      client,
      page,
      value,
      COUNT(0) AS freq
    FROM
      `httparchive.almanac.parsed_css`
    LEFT JOIN
      UNNEST(getFonts(css)) AS value
    WHERE
      date = '2019-07-01'
    GROUP BY
      client,
      page,
      value
  )
  GROUP BY
    client,
    page
)
GROUP BY
  client
