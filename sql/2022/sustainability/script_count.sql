#standardSQL
# The percentage of scripts used inline v. external
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
  percentile,
  APPROX_QUANTILES(script.total, 1000)[OFFSET(percentile * 10)] AS total_scripts,
  APPROX_QUANTILES(script.inline, 1000)[OFFSET(percentile * 10)] AS inline_script,
  APPROX_QUANTILES(script.src, 1000)[OFFSET(percentile * 10)] AS external_script,
  APPROX_QUANTILES(script.src / script.total, 1000)[OFFSET(percentile * 10)] AS pct_external_script,
  APPROX_QUANTILES(script.inline / script.total, 1000)[OFFSET(percentile * 10)] AS pct_inline_script
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    getScripts(payload) AS script
  FROM
    `httparchive.pages.2022_06_01_*`)
    UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  client
