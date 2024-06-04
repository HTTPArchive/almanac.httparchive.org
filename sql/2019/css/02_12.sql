#standardSQL
# 02_12: % of sites that use each dir value
CREATE TEMPORARY FUNCTION getDirValues(css STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var reduceValues = (values, rule) => {
    if ('rules' in rule) {
      return rule.rules.reduce(reduceValues, values);
    }
    if (!('declarations' in rule)) {
      return values;
    }

    rule.declarations.forEach(d => {
      if (d.property != 'direction') {
        return;
      }
      if (d.value.match(/rtl/i)) {
        values['rtl'] = true;
      }
      if (d.value.match(/ltr/i)) {
        values['ltr'] = true;
      }
    });
    return values;
  };
  var $ = JSON.parse(css);
  return Object.keys($.stylesheet.rules.reduce(reduceValues, {}));
} catch (e) {
  return [];
}
''';

SELECT
  client,
  direction,
  freq,
  total,
  ROUND(freq * 100 / total, 2) AS pct
FROM (
  SELECT
    client,
    direction,
    COUNT(DISTINCT page) AS freq
  FROM
    `httparchive.almanac.parsed_css`,
    UNNEST(getDirValues(css)) AS direction
  WHERE
    date = '2019-07-01'
  GROUP BY
    client,
    direction
)
JOIN (SELECT _TABLE_SUFFIX AS client, COUNT(0) AS total FROM `httparchive.summary_pages.2019_07_01_*` GROUP BY client)
USING (client)
ORDER BY
  freq / total DESC
