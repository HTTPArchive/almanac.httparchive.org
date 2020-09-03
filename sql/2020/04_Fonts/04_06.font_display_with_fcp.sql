#standardSQL
#font_display_with_fcp
CREATE TEMPORARY FUNCTION getFontDisplay(css STRING)
RETURNS ARRAY < STRING > LANGUAGE js AS '''
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
            if (d.property.toLowerCase() == 'font-display') {
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
  font_display,
  COUNT(DISTINCT page) AS freq_display,
  COUNT(0) AS total_display,
  ROUND(COUNT(DISTINCT page) * 100 / COUNT(0), 2) AS pct_display,
  COUNTIF(fast_fcp>=0.75) AS fast_fcp_display,
  COUNTIF(NOT(slow_fcp >=0.25)
    AND NOT(fast_fcp>=0.75)) AS mode_fcp_display,
  COUNTIF(slow_fcp>=0.25)*100 AS low_fcp_display,
  ROUND(COUNTIF(fast_fcp>=0.75)*100/COUNT(0),0) AS pct_fast_fcp_display,
  ROUND(COUNTIF(NOT(slow_fcp >=0.25)
    AND NOT(fast_fcp>=0.75))*100/COUNT(0),0) AS pct_mode_fcp_display,
  ROUND(COUNTIF(slow_fcp>=0.25)*100/COUNT(0),0) AS pct_slow_fcp_display,
FROM
  `httparchive.almanac.parsed_css`,
  UNNEST(getFontDisplay(css)) AS font_display
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_page
  FROM
    `httparchive.sample_data.summary_pages_*`
  GROUP BY
    _TABLE_SUFFIX,
    client)
USING
  (client)
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
WHERE
  date='2020-08-01'
GROUP BY
  client,
  font_display
