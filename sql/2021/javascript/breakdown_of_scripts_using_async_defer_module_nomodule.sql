#standardSQL
# Breakdown of scripts using Async, Defer, Module or NoModule attributes.  Also breakdown of inline vs external scripts
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
  SUM(script.async) AS async,
  SUM(script.defer) AS defer,
  SUM(script.async_and_defer) AS async_and_defer,
  SUM(script.type_module) AS module,
  SUM(script.nomodule) AS nomodule,
  SUM(script.async) / SUM(script.src) AS pct_external_async,
  SUM(script.defer) / SUM(script.src) AS pct_external_defer,
  SUM(script.async_and_defer) / SUM(script.src) AS pct_external_async_defer,
  SUM(script.type_module) / SUM(script.src) AS pct_external_module,
  SUM(script.nomodule) / SUM(script.src) AS pct_external_nomodule
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    getScripts(payload) AS script
  FROM
    `httparchive.pages.2021_07_01_*`)
GROUP BY
  client
