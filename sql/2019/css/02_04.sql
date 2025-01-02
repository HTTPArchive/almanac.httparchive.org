#standardSQL
# 02_04: % of sites that use blend modes
CREATE TEMPORARY FUNCTION usesBlendModes(css STRING)
RETURNS BOOLEAN LANGUAGE js AS '''
try {
  var reduceValues = (values, rule) => {
    if ('rules' in rule) {
      return rule.rules.reduce(reduceValues, values);
    }
    if (!('declarations' in rule)) {
      return values;
    }

    return values.concat(rule.declarations.filter(d => d.property.endsWith('blend-mode')).map(d => d.value));
  };
  var $ = JSON.parse(css);
  return $.stylesheet.rules.reduce(reduceValues, []).length > 0;
} catch (e) {
  return false;
}
''';

SELECT
  client,
  COUNTIF(num_stylesheets > 0) AS freq,
  total,
  ROUND(COUNTIF(num_stylesheets > 0) * 100 / total, 2) AS pct
FROM (
  SELECT
    client,
    page,
    COUNTIF(usesBlendModes(css)) AS num_stylesheets
  FROM
    `httparchive.almanac.parsed_css`
  WHERE
    date = '2019-07-01'
  GROUP BY
    client,
    page
)
JOIN (SELECT _TABLE_SUFFIX AS client, COUNT(0) AS total FROM `httparchive.summary_pages.2019_07_01_*` GROUP BY client)
USING (client)
GROUP BY
  client,
  total
