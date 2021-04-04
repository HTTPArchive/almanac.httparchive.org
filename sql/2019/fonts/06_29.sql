#standardSQL
# 06_29: Variation axes used for +/- 20 pt
CREATE TEMPORARY FUNCTION getFontVariationSettings(css STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var reduceValues = (values, rule) => {
    if ('rules' in rule) {
      return rule.rules.reduce(reduceValues, values);
    }
    if (!('declarations' in rule)) {
      return values;
    }
    return values.concat(rule.declarations.filter(d => d.property.toLowerCase() == 'font-variation-settings').map(d => d.value));
  };
  var $ = JSON.parse(css);
  return $.stylesheet.rules.reduce(reduceValues, []);
} catch (e) {
  return [];
}
''';

SELECT
  client,
  REGEXP_EXTRACT(LOWER(value), '[\'"]([\\w]{4})[\'"]') AS axis,
  COUNTIF(CAST(REGEXP_EXTRACT(value, '\\d+') AS NUMERIC) < 6) AS freq_under_6,
  COUNTIF(CAST(REGEXP_EXTRACT(value, '\\d+') AS NUMERIC) BETWEEN 6 AND 19) AS freq_between_6_20,
  COUNTIF(CAST(REGEXP_EXTRACT(value, '\\d+') AS NUMERIC) >= 20) AS freq_over_20,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  ROUND(COUNTIF(CAST(REGEXP_EXTRACT(value, '\\d+') AS NUMERIC) < 6) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct_under_6,
  ROUND(COUNTIF(CAST(REGEXP_EXTRACT(value, '\\d+') AS NUMERIC) BETWEEN 6 AND 19) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct_between_6_20,
  ROUND(COUNTIF(CAST(REGEXP_EXTRACT(value, '\\d+') AS NUMERIC) >= 20) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct_over_20
FROM
  `httparchive.almanac.parsed_css`,
  UNNEST(getFontVariationSettings(css)) AS values,
  UNNEST(SPLIT(values, ',')) AS value
WHERE
  date = '2019-07-01'
GROUP BY
  client,
  axis
HAVING
  axis IS NOT NULL
ORDER BY
  freq_between_6_20 / total DESC
