#standardSQL
# Distribution of @property rules per page
CREATE TEMP FUNCTION countAtProperties(css STRING) RETURNS ARRAY<INT64> LANGUAGE js AS '''
try {
  var $ = JSON.parse(css);
  return $.stylesheet.rules.flatMap(rule => {
    if (!rule.selectors) {
      return [];
    }
    return rule.selectors.filter(selector => {
      return selector.startsWith('@property');
    }).length;
  });
} catch (e) {
  return [];
}
''';

SELECT
  percentile,
  client,
  APPROX_QUANTILES(atprops_per_page, 1000)[OFFSET(percentile * 10)] AS atprops_per_page
FROM (
  SELECT
    client,
    SUM(num_atprops) AS atprops_per_page
  FROM
    `httparchive.almanac.parsed_css`,
    UNNEST(countAtProperties(css)) AS num_atprops
  WHERE
    date = '2021-07-01'
  GROUP BY
    client,
    page
),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
WHERE
  atprops_per_page > 0
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
