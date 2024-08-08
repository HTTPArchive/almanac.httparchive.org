#standardSQL
# 06_24: % of pages that use specific font-weight integers (eg 555 vs 500)
CREATE TEMPORARY FUNCTION usesVariableWeights(css STRING)
RETURNS INT64 LANGUAGE js AS '''
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

    rule.declarations.forEach(d => {
      if (d.property.toLowerCase() == 'font-weight' &&
          !isNaN(parseInt(d.value)) &&
          parseInt(d.value) % 100 > 0) {
        values++;
      }
    });
    return values;
  };
  var $ = JSON.parse(css);
  return $.stylesheet.rules.reduce(reduceValues, 0);
} catch (e) {
  return 0;
}
''';

SELECT
  client,
  COUNT(DISTINCT page) AS freq,
  total,
  ROUND(COUNT(DISTINCT page) * 100 / total, 2) AS pct
FROM
  `httparchive.almanac.parsed_css`
JOIN (SELECT _TABLE_SUFFIX AS client, COUNT(0) AS total FROM `httparchive.summary_pages.2019_07_01_*` GROUP BY _TABLE_SUFFIX)
USING (client)
WHERE
  date = '2019-07-01'
GROUP BY
  client,
  total
HAVING
  SUM(usesVariableWeights(css)) > 0
