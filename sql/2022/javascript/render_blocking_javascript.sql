#standardSQL
# Percent of pages using render-blocking JavaScript.

CREATE TEMPORARY FUNCTION getRenderBlockingScripts(payload STRING)
RETURNS INT64
LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var renderBlockingJS = $._renderBlockingJS;
  return renderBlockingJS;
} catch (e) {
  return 0;
}
''';

WITH render_blocking_scripts AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    getRenderBlockingScripts(payload) AS number_of_render_blocking_scripts
  FROM
    `httparchive.pages.2022_06_01_*`
)

SELECT
  client,
  COUNTIF(number_of_render_blocking_scripts > 0) AS pages_with_render_blocking_scripts,
  COUNT(0) AS total_pages,
  COUNTIF(number_of_render_blocking_scripts > 0) / COUNT(0) AS pct_pages_with_render_blocking_scripts
FROM
  render_blocking_scripts
GROUP BY
  client
