#standardSQL
#font_format_declared_by_font_face
CREATE TEMPORARY FUNCTION getFontFormats(css STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
var reduceValues = (values, rule) => {
if ('rules' in rule) {
return rule.rules.reduce(reduceValues, values);
}
if(!('declarations' in rule)) {
return values;
}
if (rule.type != 'font-face') {
return values;
}
// From `url(basic-sans-serif.ttf) format("truetype") (!('declarations' in rule)) {
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
 COUNT(DISTINCT page) AS freq_req,
 SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client) AS total_req,
 COUNT(DISTINCT page) / SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client) AS pct_req,
 COUNT(DISTINCT page) AS freq_page,
 SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client) AS total_page,
 COUNT(DISTINCT page) / SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client) AS pct_page,
FROM
 `httparchive.almanac.parsed_css`,
 UNNEST(getFontFormats(css)) AS format
WHERE
 date='2020-08-01'
GROUP BY
 client,
 format
ORDER BY
 client, pct_page DESC