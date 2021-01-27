#standardSQL
# 01_16: Percent of pages that include link[rel=prefetch][as=script]
CREATE TEMP FUNCTION hasScriptPrefetch(payload STRING)
RETURNS BOOLEAN LANGUAGE js AS '''
  try {
    var $ = JSON.parse(payload);
    var almanac = JSON.parse($._almanac);
    return !!almanac['link-nodes'].find(e => e.rel.toLowerCase() == 'prefetch' && e.as.toLowerCase() == 'script');
  } catch (e) {
    return false;
  }

''';

SELECT
  _TABLE_SUFFIX AS client,
  COUNTIF(hasScriptPrefetch(payload)) AS num_pages,
  COUNT(0) AS total,
  ROUND(COUNTIF(hasScriptPrefetch(payload)) * 100 / COUNT(0), 2) AS pct_script_prefetch
FROM
  `httparchive.pages.2019_07_01_*`
GROUP BY
  client
