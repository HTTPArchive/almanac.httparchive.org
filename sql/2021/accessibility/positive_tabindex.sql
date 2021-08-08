#standardSQL
# Positive tabindex value occurrences
CREATE TEMPORARY FUNCTION getTotalPositiveTabIndexes(payload STRING)
RETURNS STRUCT<total INT64, total_positive INT64> LANGUAGE js AS '''
try {
  const almanac = JSON.parse(payload);

  let total = 0;
  let total_positive = 0;
  for (const node of almanac['09.27'].nodes) {
    total++;
    if (parseInt(node.tabindex, 10) > 0) {
      total_positive++
    }
  }

  return {total, total_positive};
} catch (e) {
  return {total: 0, total_positive: 0};
}
''';

SELECT
  client,
  COUNT(0) AS total_sites,
  COUNTIF(tab_index_stats.total > 0) AS total_with_tab_indexes,
  COUNTIF(tab_index_stats.total_positive > 0) AS total_with_positive_tab_indexes,

  COUNTIF(tab_index_stats.total > 0) / COUNT(0) AS pct_with_tab_indexes,
  COUNTIF(tab_index_stats.total_positive > 0) / COUNT(0) AS pct_with_positive_tab_indexes,
  COUNTIF(tab_index_stats.total_positive > 0) / COUNTIF(tab_index_stats.total > 0) AS pct_positive_in_sites_with_tab_indexes
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    getTotalPositiveTabIndexes(JSON_EXTRACT_SCALAR(payload, '$._almanac')) AS tab_index_stats
  FROM
    `httparchive.pages.2021_07_01_*`
)
GROUP BY
  client
