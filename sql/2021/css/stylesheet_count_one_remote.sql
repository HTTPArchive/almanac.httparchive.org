#standardSQL
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
  COUNTIF(stylesheets.remote = 1) AS one_remote,
  COUNT(0) AS total,
  COUNTIF(stylesheets.remote = 1) / COUNT(0) AS pct_one_remote
FROM (
  SELECT
    _TABLE_SUFFIX,
    url,
    getStylesheets(payload) AS stylesheets
  FROM
    `httparchive.pages.2021_07_01_*`)
GROUP BY
  client
ORDER BY
  client
