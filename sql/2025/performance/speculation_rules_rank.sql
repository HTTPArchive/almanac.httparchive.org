SELECT
  IF(ranking < 100000000, CAST(ranking AS STRING), 'all') AS ranking,
  client,
  COUNT(DISTINCT page) AS total_sites,
  COUNTIF(
    custom_metrics.performance.speculation_rules IS NOT NULL AND (
      ARRAY_LENGTH(JSON_QUERY_ARRAY(custom_metrics.performance.speculation_rules.htmlRules)) > 0 OR
      ARRAY_LENGTH(JSON_QUERY_ARRAY(custom_metrics.performance.speculation_rules.httpHeaderRules)) > 0
    )
  ) AS sites_with_speculation_rules,
  COUNTIF(
    custom_metrics.performance.speculation_rules IS NOT NULL AND (
      ARRAY_LENGTH(JSON_QUERY_ARRAY(custom_metrics.performance.speculation_rules.htmlRules)) > 0 OR
      ARRAY_LENGTH(JSON_QUERY_ARRAY(custom_metrics.performance.speculation_rules.httpHeaderRules)) > 0
    )
  ) / COUNT(DISTINCT page) AS pct_speculation_rules
FROM
  `httparchive.crawl.pages`,
  UNNEST([1000, 10000, 100000, 1000000, 10000000, 100000000]) AS ranking
WHERE
  date = '2025-07-01' AND
  is_root_page AND
  rank <= ranking
GROUP BY
  ranking,
  client
ORDER BY
  ranking,
  client
