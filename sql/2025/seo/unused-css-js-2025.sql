#standardSQL
# Unused CSS and JS

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
FROM
  (
    SELECT
      client,
      page,
      rank
    FROM
      `httparchive.crawl.pages`
    WHERE
      date = '2025-07-01'
  )
LEFT JOIN
  (
    SELECT
      client,
      page,
      SAFE_DIVIDE(SAFE.INT64(lighthouse.audits.`unused-javascript`.details.overallSavingsBytes), 1024) AS unused_javascript,
      SAFE_DIVIDE(SAFE.INT64(lighthouse.audits.`unused-css-rules`.details.overallSavingsBytes), 1024) AS unused_css_rules
    FROM
      `httparchive.crawl.pages`
    WHERE
      date = '2025-07-01'
  ) USING (client, page),
  UNNEST([1000, 10000, 100000, 1000000, 10000000, 100000000]) AS rank_grouping
WHERE
  rank <= rank_grouping
GROUP BY
  client,
  rank_grouping
ORDER BY
  rank_grouping;
