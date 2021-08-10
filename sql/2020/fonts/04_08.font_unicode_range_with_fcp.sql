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
  COUNT(DISTINCT page) AS pages,
  SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client) AS total,
  COUNT(DISTINCT page) / SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client) AS pct_range,
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
    url AS page,
    CAST(JSON_EXTRACT_SCALAR(payload,
        "$['_chromeUserTiming.firstContentfulPaint']") AS INT64) AS fcp,
    CAST(JSON_EXTRACT_SCALAR(payload,
        "$['_chromeUserTiming.LargestContentfulPaint']") AS INT64) AS lcp
  FROM
    `httparchive.pages.2020_08_01_*`
  GROUP BY
    _TABLE_SUFFIX, page, payload)
USING
  (client, page)
GROUP BY
  client,
  use_unicode
ORDER BY
  pages, client DESC
