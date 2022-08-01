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
  COUNTIF(stylesheets.remote = 1) / COUNT(0) AS pct_1_remote,
  SUM(stylesheets.inline) AS num_inline_stylesheets,
  SUM(stylesheets.remote) AS num_inline_stylesheets
FROM (
  SELECT
    _TABLE_SUFFIX,
    url,
    getStylesheets(payload) AS stylesheets
  FROM
    `httparchive.pages.2022_06_01_*`
)
GROUP BY
  client
ORDER BY
  client
