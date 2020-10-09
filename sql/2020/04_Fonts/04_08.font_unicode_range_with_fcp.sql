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
    return [null];
}
''';
SELECT
  client,
  CASE
    WHEN unicode != " " THEN "unicode_ranges"
  ELSE "none"
  END AS use_unicode,
  COUNT(DISTINCT page) AS freq_range,
  total_page,
  COUNT(DISTINCT page) / total_page AS pct_range,
  COUNT(DISTINCT IF(fast_fcp >= 0.75, page, NULL)) / COUNT(DISTINCT page) AS pct_good_fcp,
  COUNT(DISTINCT IF(NOT(slow_fcp >= 0.25) AND NOT(fast_fcp >= 0.75), page, null))  / COUNT(DISTINCT page) AS pct_ni_fcp,
  COUNT(DISTINCT IF(slow_fcp >= 0.25, page, null)) / COUNT(DISTINCT page) AS pct_poor_fcp,
FROM (
  SELECT
    client,
    page,
    unicode
  FROM
    `httparchive.almanac.parsed_css`
  LEFT JOIN
    UNNEST(getFonts(css)) AS unicode
  WHERE
    date = '2020-08-01'
  GROUP BY
    client,
    page,
    unicode)
JOIN (
  SELECT
    DISTINCT origin,
    device,
    fast_fcp,
    slow_fcp
  FROM
    `chrome-ux-report.materialized.device_summary`
  WHERE
    date='2020-08-01')
ON
  CONCAT(origin, '/')=page
  AND
  IF(device='desktop', 'desktop', 'mobile')=client
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
  use_unicode,
  total_page