#standardSQL
# 08_23: Sites using positive tabindex values
CREATE TEMPORARY FUNCTION getTotalPositiveTabIndexes(payload STRING)
RETURNS STRUCT<total INT64, total_positive INT64> LANGUAGE js AS '''
try {
  const $ = JSON.parse(payload);
  const almanac = JSON.parse($._almanac);

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
  return 0;
}
''';

SELECT
  client,
  COUNT(0) AS total_sites,
  COUNTIF(tab_index_stats.total > 0) AS total_with_tab_indexes,
  COUNTIF(tab_index_stats.total_positive > 0) AS total_with_positive_tab_indexes,

  ROUND((COUNTIF(tab_index_stats.total > 0) / COUNT(0)) * 100, 2) AS pct_with_tab_indexes,
  ROUND((COUNTIF(tab_index_stats.total_positive > 0) / COUNT(0)) * 100, 2) AS pct_with_positive_tab_indexes
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    getTotalPositiveTabIndexes(payload) AS tab_index_stats
  FROM
    `httparchive.almanac.pages_desktop_*`
)
GROUP BY
  client
