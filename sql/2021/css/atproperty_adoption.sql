#standardSQL
# Percent of pages that use @property
# https://developer.mozilla.org/docs/Web/CSS/@property
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
  client,
  COUNTIF(uses_atprops) AS pages_using_atprops,
  ANY_VALUE(total_pages) AS total_pages,
  COUNTIF(uses_atprops) / ANY_VALUE(total_pages) AS pct_pages
FROM (
  SELECT
    client,
    SUM(num_atprops) > 0 AS uses_atprops
  FROM
    `httparchive.almanac.parsed_css`,
    UNNEST(countAtProperties(css)) AS num_atprops
  WHERE
    date = '2021-07-01'
  GROUP BY
    client,
    page
)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_pages
  FROM
    `httparchive.summary_pages.2021_07_01_*`
  GROUP BY
    client
)
USING (client)
GROUP BY
  client
