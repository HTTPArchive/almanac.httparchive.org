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
  percentile,
  _TABLE_SUFFIX AS client,
  COUNTIF(stylesheets.remote = 1) / COUNT(0) AS pct_1_remote,
  APPROX_QUANTILES(stylesheets.inline, 1000)[OFFSET(percentile * 10)] AS num_inline_stylesheets,
  APPROX_QUANTILES(stylesheets.remote, 1000)[OFFSET(percentile * 10)] AS num_remote_stylesheets
FROM (
  SELECT
    _TABLE_SUFFIX,
    url,
    getStylesheets(payload) AS stylesheets
  FROM
    `httparchive.pages.2022_06_01_*`
),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
