SELECT
  client,
  COUNT(DISTINCT IFNULL(TRIM(LOWER(JSON_VALUE(custom_metrics.other.almanac.html_node.lang))), '(not set)')) AS distinct_lang_count
FROM
  `httparchive.crawl.pages`
WHERE
  date = '2025-07-01'
GROUP BY
  client
ORDER BY
  distinct_lang_count DESC;
