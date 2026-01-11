#standardSQL
# Positive tabindex value occurrences

CREATE TEMPORARY FUNCTION getTotalPositiveTabIndexes(nodes_09_27 JSON)
RETURNS STRUCT<total INT64, total_positive INT64, total_negative INT64, total_zero INT64> LANGUAGE js AS '''
try {
  let total = 0;
  let total_positive = 0;
  let total_negative = 0;
  let total_zero = 0;
  for (const node of nodes_09_27) {
    total++;
    const int = parseInt(node.tabindex, 10);
    if (int > 0) {
      total_positive++;
    } else if (int < 0) {
      total_negative++;
    } else if (int === 0) {
      total_zero++;
    }
  }

  return {total, total_positive, total_negative, total_zero};
} catch (e) {
  return {total: 0, total_positive: 0, total_negative: 0, total_zero: 0};
}
''';

SELECT
  client,
  is_root_page,
  COUNT(0) AS total_sites,
  COUNTIF(tab_index_stats.total > 0) AS total_with_tab_indexes,
  COUNTIF(tab_index_stats.total_positive > 0) AS total_with_positive_tab_indexes,
  COUNTIF(tab_index_stats.total_negative > 0) AS total_with_negative_tab_indexes,
  COUNTIF(tab_index_stats.total_zero > 0) AS total_with_zero_tab_indexes,
  COUNTIF(tab_index_stats.total_negative > 0 OR tab_index_stats.total_zero > 0) AS total_with_negative_or_zero,
  COUNTIF(tab_index_stats.total > 0) / COUNT(0) AS pct_with_tab_indexes,
  COUNTIF(tab_index_stats.total_positive > 0) / COUNT(0) AS pct_with_positive_tab_indexes,
  COUNTIF(tab_index_stats.total_positive > 0) / COUNTIF(tab_index_stats.total > 0) AS pct_positive_in_sites_with_tab_indexes
FROM (
  SELECT
    client,
    is_root_page,
    getTotalPositiveTabIndexes(custom_metrics.other.almanac.`09.27`.nodes) AS tab_index_stats
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'
)
GROUP BY
  client,
  is_root_page;
