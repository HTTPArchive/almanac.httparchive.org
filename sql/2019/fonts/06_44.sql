#standardSQL
# 06_44: % of pages that use font-display
CREATE TEMPORARY FUNCTION getFontDisplay(css STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
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
      if (d.property.toLowerCase() == 'font-display') {
        values.push(d.value);
      }
    });
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
  font_display,
  COUNT(DISTINCT page) AS freq,
  total,
  ROUND(COUNT(DISTINCT page) * 100 / total, 2) AS pct
FROM
  `httparchive.almanac.parsed_css`,
  UNNEST(getFontDisplay(css)) AS font_display
JOIN (SELECT _TABLE_SUFFIX AS client, COUNT(0) AS total FROM `httparchive.summary_pages.2019_07_01_*` GROUP BY _TABLE_SUFFIX)
USING (client)
WHERE
  date = '2019-07-01'
GROUP BY
  client,
  total,
  font_display
ORDER BY
  freq / total DESC
