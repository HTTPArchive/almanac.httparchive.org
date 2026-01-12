CREATE TEMPORARY FUNCTION getFontVariationSettings(css STRING)
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
  REGEXP_EXTRACT(LOWER(values), '[\'"]([\\w]{4})[\'"]') AS axis,
  CAST(REGEXP_EXTRACT(value, '\\d+') AS NUMERIC) AS num_axis,
  COUNT(DISTINCT page) AS pages,
  SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client) AS total,
  COUNT(DISTINCT page) / SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client) AS pct
FROM
  `httparchive.almanac.parsed_css`,
  UNNEST(getFontVariationSettings(css)) AS value,
  UNNEST(SPLIT(value, ',')) AS values
WHERE
  date = '2022-07-01' -- noqa: CV09
GROUP BY
  client, axis, num_axis
HAVING
  axis IS NOT NULL
ORDER BY
  pages DESC
