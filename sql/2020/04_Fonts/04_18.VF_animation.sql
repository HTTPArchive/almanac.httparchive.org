#standardSQL
#VF_animation(??NoResult) 
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
 REGEXP_EXTRACT(LOWER(values), '[\'"]([\\w]{4})[\'"]') AS axis,
 CAST(REGEXP_EXTRACT(value, '\\d+') AS NUMERIC) AS num_axis,
 COUNT(DISTINCT page) AS freq,
 total_page,
 COUNT(DISTINCT page) * 100 / total_page AS pct
FROM
 `httparchive.almanac.parsed_css`,
 UNNEST(getfontKeyframes(css)) AS value,
 UNNEST(SPLIT(value, ',')) AS values
JOIN
 (SELECT _TABLE_SUFFIX AS client, COUNT(0) AS total_page FROM `httparchive.summary_pages.2020_08_01_*` GROUP BY _TABLE_SUFFIX)
USING
 (client)
WHERE
 date='2020-08-01'
GROUP BY
 client, axis, num_axis, total_page
HAVING
 axis IS NOT NULL

