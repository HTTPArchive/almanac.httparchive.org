#standardSQL
#font_weight_font_style
CREATE TEMPORARY FUNCTION getFonts(css STRING)
RETURNS ARRAY<STRUCT<weight STRING, stretch STRING, style STRING>> LANGUAGE js AS '''
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
        var props = {};
        rule.declarations.forEach(d => {
            if (d.property.toLowerCase() == 'font-weight') {
                props.weight = d.value;
            } else if (d.property.toLowerCase() == 'font-stretch') {
                props.stretch = d.value;
            } else if (d.property.toLowerCase() == 'font-style') {
                props.style = d.value;
            }
        });
         {
            values.push(props);
        }
        return values;
    };
    var $ = JSON.parse(css);
    return $.stylesheet.rules.reduce(reduceValues, []);
} catch (e) {
    return [null];
}
''';
SELECT
  client,
  style,
  weight,
  stretch,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT DISTINCT
    client,
    page,
    font.style AS style,
    font.weight AS weight,
    font.stretch AS stretch
  FROM
    `httparchive.almanac.parsed_css`
  LEFT JOIN UNNEST(getFonts(css)) AS font
  WHERE
    date = '2020-08-01')
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2020_08_01_*`
  GROUP BY
    client)
USING
  (client)
GROUP BY
  client,
  style,
  weight,
  stretch
ORDER BY
  pct DESC
