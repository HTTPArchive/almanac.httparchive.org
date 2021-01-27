#standardSQL
# 01_14: Percent of pages that include link[rel=preload][as=script]
CREATE TEMP FUNCTION hasScriptPreload(payload STRING)
RETURNS BOOLEAN LANGUAGE js AS '''
  try {
    var $ = JSON.parse(payload);
    var almanac = JSON.parse($._almanac);
    return !!almanac['link-nodes'].find(e => e.rel.toLowerCase() == 'preload' && e.as.toLowerCase() == 'script');
  } catch (e) {
    return false;
  }

''';

SELECT
  _TABLE_SUFFIX AS client,
  COUNTIF(hasScriptPreload(payload)) AS num_pages,
  COUNT(0) AS total,
  ROUND(COUNTIF(hasScriptPreload(payload)) * 100 / COUNT(0), 2) AS pct_script_preload
FROM
  `httparchive.pages.2019_07_01_*`
GROUP BY
  client
