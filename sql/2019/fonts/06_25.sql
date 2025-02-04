#standardSQL
# 06_25: % of pages that use @supports font-variant-*
CREATE TEMPORARY FUNCTION checksSupports(css STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var reduceValues = (values, rule) => {
    if (rule.type == 'supports' && rule.supports.toLowerCase().includes('font-variation-settings')) {
      values.push(rule.supports.toLowerCase());
    }
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
  COUNT(DISTINCT page) AS freq,
  total,
  ROUND(COUNT(DISTINCT page) * 100 / total, 2) AS pct
FROM
  `httparchive.almanac.parsed_css`
JOIN (SELECT _TABLE_SUFFIX AS client, COUNT(0) AS total FROM `httparchive.summary_pages.2019_07_01_*` GROUP BY _TABLE_SUFFIX)
USING (client)
WHERE
  date = '2019-07-01' AND
  ARRAY_LENGTH(checksSupports(css)) > 0
GROUP BY
  client,
  total
