#standardSQL
# % of sites that use each type of resource hint grouped by rank

CREATE TEMPORARY FUNCTION getResourceHints(payload STRING)
RETURNS STRUCT<preload BOOLEAN, prefetch BOOLEAN, preconnect BOOLEAN, prerender BOOLEAN, `dns-prefetch` BOOLEAN, `modulepreload` BOOLEAN>
LANGUAGE js AS '''
var hints = ['preload', 'prefetch', 'preconnect', 'prerender', 'dns-prefetch', 'modulepreload'];
try {
  var $ = JSON.parse(payload);
  var almanac = JSON.parse($._almanac);
  return hints.reduce((results, hint) => {
    results[hint] = !!almanac['link-nodes'].nodes.find(link => link.rel.toLowerCase() == hint);
    return results;
  }, {});
} catch (e) {
  return hints.reduce((results, hint) => {
    results[hint] = false;
    return results;
  }, {});
}
''' ;

SELECT
  client,
  rank,
  COUNT(0) AS total,
  COUNTIF(hints.preload) AS preload,
  COUNTIF(hints.preload) / COUNT(0) AS pct_preload,
  COUNTIF(hints.prefetch) AS prefetch,
  COUNTIF(hints.prefetch) / COUNT(0) AS pct_prefetch,
  COUNTIF(hints.preconnect) AS preconnect,
  COUNTIF(hints.preconnect) / COUNT(0) AS pct_preconnect,
  COUNTIF(hints.prerender) AS prerender,
  COUNTIF(hints.prerender) / COUNT(0) AS pct_prerender,
  COUNTIF(hints.`dns-prefetch`) AS dns_prefetch,
  COUNTIF(hints.`dns-prefetch`) / COUNT(0) AS pct_dns_prefetch,
  COUNTIF(hints.modulepreload) AS modulepreload,
  COUNTIF(hints.modulepreload) / COUNT(0) AS pct_modulepreload
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    getResourceHints(payload) AS hints
  FROM
    `httparchive.pages.2021_07_01_*`
)
JOIN (
    SELECT
      _TABLE_SUFFIX AS client,
      url AS page,
      rank AS _rank
    FROM
      `httparchive.summary_pages.2021_07_01_*`
)
USING
  (client, page),
  UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS rank
WHERE
  _rank <= rank
GROUP BY
  client,
  rank
ORDER BY
  client,
  rank
