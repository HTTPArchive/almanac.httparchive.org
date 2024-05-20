#standardSQL
# Breakdown of inline vs external scripts
CREATE TEMPORARY FUNCTION getScripts(payload STRING)
RETURNS STRUCT<total INT64, inline INT64, src INT64, async INT64, defer INT64, async_and_defer INT64, type_module INT64, nomodule INT64>
LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var javascript = JSON.parse($._javascript);
  return javascript.script_tags;
} catch (e) {
  return {};
}
''';

SELECT
  client,
  SUM(script.total) AS total_scripts,
  SUM(script.inline) AS inline_script,
  SUM(script.src) AS external_script,
  SUM(script.src) / SUM(script.total) AS pct_external_script,
  SUM(script.inline) / SUM(script.total) AS pct_inline_script,
  APPROX_QUANTILES(SAFE_DIVIDE(script.src, script.total), 1000)[OFFSET(500)] AS median_external,
  APPROX_QUANTILES(SAFE_DIVIDE(script.inline, script.total), 1000)[OFFSET(500)] AS median_inline
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    getScripts(payload) AS script
  FROM
    `httparchive.pages.2022_06_01_*`
)
GROUP BY
  client
