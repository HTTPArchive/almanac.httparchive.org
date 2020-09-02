#standardSQL
#VF_axis
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
 COUNT(0) AS freq_axis,
 SUM(COUNT(0)) OVER (PARTITION BY client) AS total_axis,
 ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct_axis
FROM
 `httparchive.almanac.parsed_css`,
 UNNEST(getFontVariationSettings(css)) AS value,
 UNNEST(SPLIT(value, ',')) AS values
GROUP BY
 client, axis
HAVING
 axis IS NOT NULL
ORDER BY
 freq_axis / total_axis DESC
