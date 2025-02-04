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
    client,
    url,
    rank,
    number_of_render_blocking_scripts
  FROM (
    SELECT
      client,
      page AS url,
      getRenderBlockingScripts(payload) AS number_of_render_blocking_scripts
    FROM
      `httparchive.all.pages`
    WHERE
      date = '2024-06-01'
  )
  JOIN (
    SELECT
      _TABLE_SUFFIX AS client,
      url,
      rank
    FROM
      `httparchive.summary_pages.2024_06_01_*`
  )
  USING (client, url)
)

SELECT
  client,
  rank_grouping,
  COUNTIF(number_of_render_blocking_scripts > 0) AS pages_with_render_blocking_scripts,
  COUNT(0) AS total_pages,
  COUNTIF(number_of_render_blocking_scripts > 0) / COUNT(0) AS pct_pages_with_render_blocking_scripts
FROM
  render_blocking_scripts,
  UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS rank_grouping
WHERE
  rank <= rank_grouping
GROUP BY
  client,
  rank_grouping
ORDER BY
  client,
  rank_grouping
