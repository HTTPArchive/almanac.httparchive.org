#standardSQL
#VF_animation 
CREATE TEMPORARY FUNCTION getfontKeyframes(css STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
var reduceValues = (values, rule) => {
if (rule.type == 'keyframes' && rule.supports.toLowerCase().includes('font-variation-settings')) {
values.push(rule.supports.toLowerCase());
}
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
 COUNT(DISTINCT page) AS freq,
 total_page,
 ROUND(COUNT(DISTINCT page) * 100 / total_page, 2) AS pct
FROM
 `httparchive.almanac.parsed_css`
JOIN
 (SELECT _TABLE_SUFFIX AS client, COUNT(0) AS total_page FROM `httparchive.summary_pages.2020_08_01_*` GROUP BY _TABLE_SUFFIX)
USING
 (client)
WHERE
 ARRAY_LENGTH(getfontKeyframes(css)) > 0
GROUP BY
 client, total_page
