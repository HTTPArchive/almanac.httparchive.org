#standardSQL
# Percent of pages using render-blocking JavaScript.
CREATE TEMPORARY FUNCTION getRenderBlockingScripts(payload JSON)
RETURNS INT64
LANGUAGE js AS '''
try {
  var renderBlockingJS = JSON.parse(payload)
  return renderBlockingJS;
} catch (e) {
  return 0;
}
''';

WITH render_blocking_scripts AS (
  SELECT
    client,
    page,
    rank,
    getRenderBlockingScripts(payload['_renderBlockingJS']) AS number_of_render_blocking_scripts
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2024-06-01' AND
    is_root_page
)

SELECT
  client,
  rank_grouping,
  COUNTIF(number_of_render_blocking_scripts > 0) AS pages_with_render_blocking_scripts,
  COUNT(0) AS total_pages,
  COUNTIF(number_of_render_blocking_scripts > 0) / COUNT(0) AS pct_pages_with_render_blocking_scripts
FROM
  render_blocking_scripts,
  UNNEST([1000, 10000, 100000, 1000000, 10000000, 100000000]) AS rank_grouping
WHERE
  rank <= rank_grouping
GROUP BY
  client,
  rank_grouping
ORDER BY
  client,
  rank_grouping
