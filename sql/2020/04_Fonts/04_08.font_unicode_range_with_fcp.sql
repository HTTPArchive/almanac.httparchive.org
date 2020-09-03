#standardSQL
#font_unicode_range_with_fcp
CREATE TEMPORARY FUNCTION getFonts(css STRING)
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
            if (d.property.toLowerCase() == 'unicode-range') {
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
  COUNTIF(ranges > 0) AS freq_range,
  total_page,
  ROUND(COUNTIF(ranges > 0) * 100 / total_page, 2) AS pct_range,
  COUNTIF(fast_fcp>=0.75)*100/COUNT(0) AS pct_fast_fcp_unicode,
  COUNTIF(NOT(slow_fcp >=0.25)
    AND NOT(fast_fcp>=0.75)) *100/COUNT(0) AS pct_avg_fcp_unicode,
  COUNTIF(slow_fcp>=0.25)*100/COUNT(0) AS pct_slow_fcp_unicode,
FROM (
  SELECT
    client,
    page,
    SUM(ARRAY_LENGTH(getFonts(css))) AS ranges
  FROM
    `httparchive.almanac.parsed_css`
  WHERE
    date = '2020-08-01'
  GROUP BY
    client,
    page)
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
    _TABLE_SUFFIX)
USING
  (client)
GROUP BY
  client,
  total_page
