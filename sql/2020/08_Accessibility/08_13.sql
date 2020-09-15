#standardSQL
# 08_13: Most popular accesskey or aria-keyshortcuts keys
CREATE TEMPORARY FUNCTION getShortcuts(payload STRING)
RETURNS ARRAY<STRUCT<type STRING, shortcut STRING>> LANGUAGE js AS '''
try {
  const almanac = JSON.parse(payload);

  const collector = [];
  function addToCollector(array, type) {
    // remove any possible dupes
    let arr_deduped = new Set(array);
    arr_deduped.forEach((shortcut) => collector.push({type, shortcut}));
  }

  addToCollector(
      almanac.shortcuts_stats.aria_shortcut_values,
      'aria_shortcut');
  addToCollector(
      almanac.shortcuts_stats.accesskey_values,
      'accesskey');

  return collector;
} catch (e) {
  return [];
}
''';

SELECT
  _TABLE_SUFFIX AS client,
  type_and_key.type AS type,
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX, type) AS total_type_uses,

  type_and_key.shortcut AS shortcut,
  COUNT(0) AS total_uses,
  ROUND((COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX, type)) * 100, 2) AS pct_of_type_uses
FROM
  `httparchive.pages.2020_08_01_*`,
  UNNEST(getShortcuts(JSON_EXTRACT_SCALAR(payload, "$._almanac"))) AS type_and_key
GROUP BY
  client,
  type_and_key.type,
  type_and_key.shortcut
ORDER BY
  client,
  type_and_key.type,
  total_uses DESC
