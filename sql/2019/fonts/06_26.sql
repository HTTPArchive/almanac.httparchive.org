#standardSQL
# 06_26: % of pages using font-stretch
CREATE TEMPORARY FUNCTION usesFontStretch(css STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var reduceValues = (values, rule) => {
    if ('rules' in rule) {
      return rule.rules.reduce(reduceValues, values);
    }
    if (!('declarations' in rule)) {
      return values;
    }
    return values.concat(rule.declarations.filter(d => d.property.toLowerCase() == 'font-stretch').map(d => d.value));
  };
  var $ = JSON.parse(css);
  return $.stylesheet.rules.reduce(reduceValues, []);
} catch (e) {
  return [];
}
''';

SELECT
  client,
  COUNT(DISTINCT page) AS freq,
  total,
  ROUND(COUNT(DISTINCT page) * 100 / total, 2) AS pct
FROM
  `httparchive.almanac.parsed_css`
JOIN
  (SELECT _TABLE_SUFFIX AS client, COUNT(0) AS total FROM `httparchive.summary_pages.2019_07_01_*` GROUP BY client)
USING
  (client)
WHERE
  date = '2019-07-01' AND
  ARRAY_LENGTH(usesFontStretch(css)) > 0
GROUP BY
  client,
  total
