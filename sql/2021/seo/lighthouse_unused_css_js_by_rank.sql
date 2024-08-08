#standardSQL
# Gather lighthouse unused css and js by CrUX rank

SELECT
  client,
  rank_grouping,
  COUNT(DISTINCT page) AS pages,
  SUM(unused_javascript) / COUNT(DISTINCT page) AS unused_javascript_kib_avg,
  SUM(unused_css_rules) / COUNT(DISTINCT page) AS unused_css_rules_kib_avg

FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    rank
  FROM
    `httparchive.summary_pages.2021_07_01_*`
  WHERE _TABLE_SUFFIX = 'mobile'
)

LEFT JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    SAFE_DIVIDE(CAST(JSON_EXTRACT_SCALAR(report, '$.audits.unused-javascript.details.overallSavingsBytes') AS INT64), 1024) AS unused_javascript,
    SAFE_DIVIDE(CAST(JSON_EXTRACT_SCALAR(report, '$.audits.unused-css-rules.details.overallSavingsBytes') AS INT64), 1024) AS unused_css_rules
  FROM
    `httparchive.lighthouse.2021_07_01_*`
)

USING (client, page),
  UNNEST([1e3, 1e4, 1e5, 1e6, 1e7]) AS rank_grouping
WHERE
  rank <= rank_grouping
GROUP BY
  client,
  rank_grouping
ORDER BY
  rank_grouping
