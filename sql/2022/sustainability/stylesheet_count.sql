#standardSQL
# The percentage of stylesheets used inline v. external
CREATE TEMPORARY FUNCTION getStylesheets(payload STRING)
RETURNS STRUCT<remote INT64, inline INT64> LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload)
  var sass = JSON.parse($._sass);
  return sass.stylesheets;
} catch (e) {
  return null;
}
''';

SELECT
  _TABLE_SUFFIX AS client,
  percentile,
  APPROX_QUANTILES(SAFE_DIVIDE(stylesheets.remote, (stylesheets.inline + stylesheets.remote)), 1000)[OFFSET(percentile * 10)] AS pct_remote,
  APPROX_QUANTILES(stylesheets.inline, 1000)[OFFSET(percentile * 10)] AS num_inline_stylesheets,
  APPROX_QUANTILES(stylesheets.remote, 1000)[OFFSET(percentile * 10)] AS num_inline_stylesheets
FROM (
  SELECT
    _TABLE_SUFFIX,
    url,
    getStylesheets(payload) AS stylesheets
  FROM
    `httparchive.pages.2022_06_01_*`,
    UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
)
GROUP BY
  client,
  percentile
ORDER BY
  client,
  percentile
