#standardSQL
# % of pages having skip links

SELECT
  client,
  is_root_page,
  COUNTIF(CAST(JSON_VALUE(custom_metrics.other.almanac.`seo-anchor-elements`.earlyHash) AS INT64) > 0) AS pages,
  COUNT(0) AS total,
  COUNTIF(CAST(JSON_VALUE(custom_metrics.other.almanac.`seo-anchor-elements`.earlyHash) AS INT64) > 0) / COUNT(0) AS pct
FROM
  `httparchive.crawl.pages`
WHERE
  date = '2025-07-01'
GROUP BY
  client,
  is_root_page;
