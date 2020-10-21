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
  APPROX_QUANTILES(fcp, 1000)[OFFSET(500)] AS median_fcp,
  APPROX_QUANTILES(lcp, 1000)[OFFSET(500)] AS median_lcp
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
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_page,
    CAST(JSON_EXTRACT_SCALAR(payload,
        "$['_chromeUserTiming.firstContentfulPaint']") AS INT64) AS fcp,
    CAST(JSON_EXTRACT_SCALAR(payload,
        "$['_chromeUserTiming.LargestContentfulPaint']") AS INT64) AS lcp,
  FROM
    `httparchive.pages.2020_08_01_*`
  GROUP BY
    _TABLE_SUFFIX,
    payload)
USING
  (client)
GROUP BY
  client,
  use_unicode,
  total_page
ORDER BY
  freq_range, client DESC