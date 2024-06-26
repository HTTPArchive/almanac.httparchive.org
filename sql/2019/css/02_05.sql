#standardSQL
# 02_05: % of sites that use logical properties
CREATE TEMPORARY FUNCTION usesLogicalProps(css STRING)
RETURNS BOOLEAN LANGUAGE js AS '''
try {
  var isLogicalProperty = (prop) => {
    prop = prop.toLowerCase();
    return prop.includes('block-start') ||
        prop.includes('block-end') ||
        prop.includes('inline-start') ||
        prop.includes('inline-end') ||
        prop == 'block-size' ||
        prop == 'inline-size';
  }

  var reduceValues = (values, rule) => {
    if ('rules' in rule) {
      return rule.rules.reduce(reduceValues, values);
    }
    if (!('declarations' in rule)) {
      return values;
    }

    return values.concat(rule.declarations.filter(d => isLogicalProperty(d.property)).map(d => d.value));
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
    COUNTIF(usesLogicalProps(css)) AS num_stylesheets
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
