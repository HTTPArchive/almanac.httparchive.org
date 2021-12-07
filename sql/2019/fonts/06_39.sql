#standardSQL
# 06_39-41: Font formats declared together
CREATE TEMPORARY FUNCTION getFontFormats(css STRING)
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
    // From `url(basic-sans-serif.ttf) format("truetype")` get `truetype`.
    var re = /format\\(["']?(\\w+)['"]?\\)/;
    return values.concat(rule.declarations.filter(d => d.property.toLowerCase() == 'src').map(d => {
      // Convert `format(woff), format(svg)` into `svg, woff`
      return d.value.toLowerCase().split(',').filter(src => re.test(src)).map(src => src.match(re)[1]).sort().join(', ');
    }));
  };
  var $ = JSON.parse(css);
  return $.stylesheet.rules.reduce(reduceValues, []);
} catch (e) {
  return [];
}
''';

SELECT
  client,
  formats,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct
FROM
  `httparchive.almanac.parsed_css`,
  UNNEST(getFontFormats(css)) AS formats
WHERE
  date = '2019-07-01'
GROUP BY
  client,
  formats
HAVING
  formats IS NOT NULL AND
  formats != ''
ORDER BY
  freq / total DESC
