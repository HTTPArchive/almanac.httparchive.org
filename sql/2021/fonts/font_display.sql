#standardSQL
#font_display
CREATE TEMPORARY FUNCTION getFontDisplay(css STRING)
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
            if (d.property.toLowerCase() == 'font-display') {
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
  font_display,
  COUNT(DISTINCT page) AS pages,
  SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client) AS total,
  COUNT(DISTINCT page) / SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client) AS pct_display,
  APPROX_QUANTILES(fcp, 1000)[OFFSET(500)] AS median_fcp,
  APPROX_QUANTILES(lcp, 1000)[OFFSET(500)] AS median_lcp
FROM (
  SELECT DISTINCT
    client,
    page,
    font_display
  FROM
    `httparchive.almanac.parsed_css`
  LEFT JOIN
    UNNEST(getFontDisplay(css)) AS font_display
  WHERE
    date = '2021-07-01'
)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    CAST(JSON_EXTRACT_SCALAR(
      payload,
      "$['_chromeUserTiming.firstContentfulPaint']"
    ) AS INT64) AS fcp,
    CAST(JSON_EXTRACT_SCALAR(
      payload,
      "$['_chromeUserTiming.LargestContentfulPaint']"
    ) AS INT64) AS lcp
  FROM
    `httparchive.pages.2021_07_01_*`
  GROUP BY
    _TABLE_SUFFIX,
    url,
    payload
)
USING (client, page)
GROUP BY
  client,
  font_display
ORDER BY
  pages DESC
