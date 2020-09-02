#standardSQL
#font_subset_with_fcp
CREATE TEMPORARY FUNCTION getFont(css STRING)
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
rule.declarations.forEach(d => {
if (d.property.toLowerCase() == 'subset') {
values.push(d.value);
}
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
  font_subset,
  COUNT(DISTINCT page) AS freq_subset,
  COUNT(0) AS total_subset,
  ROUND(COUNT(DISTINCT page) * 100 / COUNT(0), 2) AS pct_subset,
  COUNTIF(fast_fcp>=0.75)*100/COUNT(0) AS pct_fast_fcp_subset,
  COUNTIF(NOT(slow_fcp >=0.25)
    AND NOT(fast_fcp>=0.75)) *100/COUNT(0) AS pct_mode_fcp_subset,
  COUNTIF(slow_fcp>=0.25)*100/COUNT(0) AS pct_slow_fcp_subset,
FROM
  `httparchive.almanac.parsed_css`,
  UNNEST(getFont(css)) AS font_subset
JOIN (
  SELECT
    origin,
    fast_fcp,
    slow_fcp,
  FROM
    `chrome-ux-report.materialized.device_summary`
  WHERE
    yyyymm=202007)
ON
  CONCAT(origin, '/')=page
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_page
  FROM
    `httparchive.summary_pages.2020_08_01_*`
  GROUP BY
    _TABLE_SUFFIX,
    client)
USING
  (client)
GROUP BY
  client,
  font_subset
