#standardSQL
# 06_21: % of pages with VF using font-variation-settings
CREATE TEMPORARY FUNCTION usesFontVariationSettings(css STRING)
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
  COUNT(0) AS freq,
  total,
  ROUND(COUNT(0) * 100 / total, 2) AS pct
FROM (
  SELECT
    client,
    page
  FROM
    `httparchive.almanac.parsed_css`
  WHERE
    date = '2019-07-01'
  GROUP BY
    client,
    page
  HAVING
    SUM(ARRAY_LENGTH(usesFontVariationSettings(css))) > 0)
JOIN
  (SELECT client, page
    FROM `httparchive.almanac.requests`
    WHERE date = '2019-07-01' AND type = 'font' AND JSON_EXTRACT_SCALAR(payload, '$._font_details.table_sizes.gvar') IS NOT NULL
    GROUP BY client, page)
USING
  (client, page)
JOIN
  (SELECT _TABLE_SUFFIX AS client, COUNT(0) AS total FROM `httparchive.summary_pages.2019_07_01_*` GROUP BY client)
USING
  (client)
GROUP BY
  client,
  total
