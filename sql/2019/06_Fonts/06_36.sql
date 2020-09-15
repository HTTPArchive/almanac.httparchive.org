#standardSQL
# 06_36-38: Top declared font formats
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
    rule.declarations.filter(d => d.property.toLowerCase() == 'src').map(d => d.value).forEach(srcs => {
      srcs.split(',').filter(src => re.test(src)).forEach(src => {
        values.push(src.toLowerCase().match(re)[1]);
      });
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
  format,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct
FROM
  `httparchive.almanac.parsed_css`,
  UNNEST(getFontFormats(css)) AS format
GROUP BY
  client,
  format
ORDER BY
  freq / total DESC