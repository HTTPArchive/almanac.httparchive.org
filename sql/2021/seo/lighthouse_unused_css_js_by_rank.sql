#standardSQL
# Gather SEO data from lighthouse

SELECT
  client,
  CAST(rank AS INT64) AS rank,
  COUNT(DISTINCT page) AS pages,
  ROUND(SUM(unused_javascript)/COUNT(DISTINCT page), 2) AS unused_javascript_kib_avg,
  ROUND(SUM(unused_css_rules)/COUNT(DISTINCT page), 2) AS unused_css_rules_kib_avg

FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    rank AS _rank
  FROM
    `httparchive.summary_pages.2021_07_01_*`
  WHERE _TABLE_SUFFIX = 'mobile')

LEFT JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    ROUND(SAFE_DIVIDE(CAST(JSON_EXTRACT_SCALAR(report, '$.audits.unused-javascript.details.overallSavingsBytes') AS INT64),1024), 2)  AS unused_javascript,
    ROUND(SAFE_DIVIDE(CAST(JSON_EXTRACT_SCALAR(report, '$.audits.unused-css-rules.details.overallSavingsBytes') AS INT64),1024), 2)  AS unused_css_rules
  FROM
    `httparchive.lighthouse.2021_07_01_*`)

USING
  (client, page),
  UNNEST([1e3, 1e4, 1e5, 1e6, 1e7]) AS rank
WHERE
  _rank <= rank
GROUP BY
  client,
  rank
ORDER BY
  rank
