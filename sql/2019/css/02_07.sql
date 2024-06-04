#standardSQL
# 02_07: % of sites that use each length unit
CREATE TEMPORARY FUNCTION getLengthUnit(css STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  // https://developer.mozilla.org/docs/Web/CSS/length
  var units = ['cap', 'ch', 'em', 'ex', 'ic', 'lh', 'rem',
      'rlh', 'vh', 'vw', 'vi', 'vb', 'vmin', 'vmax',
      'px', 'cm', 'nm', 'Q', 'in', 'pc', 'pt'];
  units = new Map(units.map(u => {
    return [u, new RegExp(`\\\\d${u}\\\\b`)];
  }));
  var getLengthUnit = (value) => {
    for ([unit, re] of units) {
      if (value.match(re)) {
        return unit;
      }
    }
    return null;
  }

  var reduceValues = (values, rule) => {
    if ('rules' in rule) {
      return rule.rules.reduce(reduceValues, values);
    }
    if (!('declarations' in rule)) {
      return values;
    }

    rule.declarations.forEach(d => {
      if (d.value.length > 20) return;
      var unit = getLengthUnit(d.value);
      if (unit) {
        values[unit] = true;
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
  unit,
  freq,
  total,
  ROUND(freq * 100 / total, 2) AS pct
FROM (
  SELECT
    client,
    unit,
    COUNT(DISTINCT page) AS freq
  FROM
    `httparchive.almanac.parsed_css`,
    UNNEST(getLengthUnit(css)) AS unit
  WHERE
    date = '2019-07-01'
  GROUP BY
    client,
    unit
)
JOIN (SELECT _TABLE_SUFFIX AS client, COUNT(0) AS total FROM `httparchive.summary_pages.2019_07_01_*` GROUP BY client)
USING (client)
ORDER BY
  freq / total DESC
