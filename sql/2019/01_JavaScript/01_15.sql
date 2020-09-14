#standardSQL
# 01_15: Percent of pages that include link[rel=modulepreload]
CREATE TEMP FUNCTION hasModulePreload(payload STRING)
RETURNS BOOLEAN LANGUAGE js AS '''
  try {
    var $ = JSON.parse(payload);
    var almanac = JSON.parse($._almanac);
    return !!almanac['link-nodes'].find(e => e.rel.toLowerCase() == 'modulepreload');
  } catch (e) {
    return false;
  }

''';

SELECT
  _TABLE_SUFFIX AS client,
  COUNTIF(hasModulePreload(payload)) AS num_pages,
  COUNT(0) AS total,
  ROUND(COUNTIF(hasModulePreload(payload)) * 100 / COUNT(0), 2) AS pct_modulepreload
FROM
  `httparchive.pages.2019_07_01_*`
GROUP BY
  client
