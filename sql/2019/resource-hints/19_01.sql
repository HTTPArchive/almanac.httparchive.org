#standardSQL
# 19_01: % of sites that use each type of hint.
CREATE TEMPORARY FUNCTION getResourceHints(payload STRING)
RETURNS STRUCT<preload BOOLEAN, prefetch BOOLEAN, preconnect BOOLEAN, prerender BOOLEAN, `dns-prefetch` BOOLEAN>
LANGUAGE js AS '''
var hints = ['preload', 'prefetch', 'preconnect', 'prerender', 'dns-prefetch'];
try {
  var $ = JSON.parse(payload);
  var almanac = JSON.parse($._almanac);
  return hints.reduce((results, hint) => {
    results[hint] = !!almanac['link-nodes'].find(link => link.rel.toLowerCase() == hint);
    return results;
  }, {});
} catch (e) {
  return hints.reduce((results, hint) => {
    results[hint] = false;
    return results;
  }, {});
}
''';

SELECT
  client,
  COUNTIF(hints.preload) AS preload,
  ROUND(COUNTIF(hints.preload) * 100 / COUNT(0), 2) AS pct_preload,
  COUNTIF(hints.prefetch) AS prefetch,
  ROUND(COUNTIF(hints.prefetch) * 100 / COUNT(0), 2) AS pct_prefetch,
  COUNTIF(hints.preconnect) AS preconnect,
  ROUND(COUNTIF(hints.preconnect) * 100 / COUNT(0), 2) AS pct_preconnect,
  COUNTIF(hints.prerender) AS prerender,
  ROUND(COUNTIF(hints.prerender) * 100 / COUNT(0), 2) AS pct_prerender,
  COUNTIF(hints.`dns-prefetch`) AS dns_prefetch,
  ROUND(COUNTIF(hints.`dns-prefetch`) * 100 / COUNT(0), 2) AS pct_dns_prefetch
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    getResourceHints(payload) AS hints
  FROM
    `httparchive.pages.2019_07_01_*`
)
GROUP BY
  client
