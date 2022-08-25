#standardSQL
# Gather lighthouse unused css and js by CrUX rank

SELECT
  client,
  rank_grouping,
  CASE
    WHEN rank_grouping = 100000000 THEN 'all'
    ELSE FORMAT("%'d", rank_grouping)
  END AS ranking,
  COUNT(DISTINCT page) AS pages,
  SUM(unused_javascript) / COUNT(DISTINCT page) AS unused_javascript_kib_avg,
  SUM(unused_css_rules) / COUNT(DISTINCT page) AS unused_css_rules_kib_avg

FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    rank
  FROM
    `httparchive.summary_pages.2022_07_01_*` -- noqa: L062
  )

LEFT JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    SAFE_DIVIDE(CAST(JSON_EXTRACT_SCALAR(report, '$.audits.unused-javascript.details.overallSavingsBytes') AS INT64), 1024) AS unused_javascript,
    SAFE_DIVIDE(CAST(JSON_EXTRACT_SCALAR(report, '$.audits.unused-css-rules.details.overallSavingsBytes') AS INT64), 1024) AS unused_css_rules
  FROM
    `httparchive.lighthouse.2022_07_01_*`) -- noqa: L062

USING
  (client, page),
  UNNEST([1000, 10000, 100000, 1000000, 10000000, 100000000]) AS rank_grouping
WHERE
  rank <= rank_grouping
GROUP BY
  client,
  rank_grouping
ORDER BY
  rank_grouping
