#standardSQL
#VF axis values(6.7T)
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
 REGEXP_EXTRACT(LOWER(value), '[\'"]([\\w]{4})[\'"]') AS axis,
 CAST(REGEXP_EXTRACT(value, '\\d+') AS NUMERIC) AS num_axis,
 COUNTIF(CAST(REGEXP_EXTRACT(value, '\\d+') AS NUMERIC) < 6) AS freq_under_6_axis,
 COUNTIF(CAST(REGEXP_EXTRACT(value, '\\d+') AS NUMERIC) BETWEEN 6 AND 19) AS freq_between_6_20_axis,
 COUNTIF(CAST(REGEXP_EXTRACT(value, '\\d+') AS NUMERIC) >= 20) AS freq_over_20_axis,
 COUNT(0) AS sub_total_axis,
 SUM(COUNT(0)) OVER (PARTITION BY client) AS total_axis,
 ROUND(COUNTIF(CAST(REGEXP_EXTRACT(value, '\\d+') AS NUMERIC) < 6) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct_under_6_axis,
 ROUND(COUNTIF(CAST(REGEXP_EXTRACT(value, '\\d+') AS NUMERIC) BETWEEN 6 AND 19) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct_between_6_20_axis,
 ROUND(COUNTIF(CAST(REGEXP_EXTRACT(value, '\\d+') AS NUMERIC) >= 20) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct_over_20_axis
FROM 
 `httparchive.almanac.parsed_css`,
 UNNEST(getFontVariationSettings(css)) AS value,
 UNNEST(SPLIT(value, ',')) AS values
GROUP BY 
 client, axis, num_axis
HAVING 
 axis IS NOT NULL
ORDER BY  
 freq_between_6_20_axis DESC
