#standardSQL
# % of sites that use custom properties.
# Same query as 2019, to compare trend
CREATE TEMPORARY FUNCTION usesCustomProps(css STRING)
RETURNS BOOLEAN LANGUAGE js AS '''
try {
  var reduceValues = (values, rule) => {
    if ('rules' in rule) {
      return rule.rules.reduce(reduceValues, values);
    }
    if (!('declarations' in rule)) {
      return values;
    }

    return values.concat(rule.declarations.filter(d => d.property.startsWith(`--`)));
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
  COUNTIF(num_stylesheets > 0) / total AS pct
FROM (
  SELECT
    client,
    page,
    COUNTIF(usesCustomProps(css)) AS num_stylesheets
  FROM
    `httparchive.almanac.parsed_css`
  WHERE
    date = '2022-07-01' -- noqa: CV09
  GROUP BY
    client,
    page
)
JOIN (SELECT _TABLE_SUFFIX AS client, COUNT(0) AS total FROM `httparchive.summary_pages.2022_07_01_*` GROUP BY client) -- noqa: CV09
USING (client)
GROUP BY
  client,
  total
