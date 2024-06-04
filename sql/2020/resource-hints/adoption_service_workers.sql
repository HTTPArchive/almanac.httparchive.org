#standardSQL
# 21_16: Usage of resource hints by service-worker controlled pages
CREATE TEMPORARY FUNCTION getResourceHints(payload STRING)
RETURNS STRUCT<preload BOOLEAN, prefetch BOOLEAN, preconnect BOOLEAN, prerender BOOLEAN, `dns-prefetch` BOOLEAN>
LANGUAGE js AS '''
var hints = ['preload', 'prefetch', 'preconnect', 'prerender', 'dns-prefetch'];
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
''';

SELECT
  client,
  COUNTIF(hints.preload) AS preload,
  COUNTIF(hints.preload) / COUNT(0) AS pct_preload,
  COUNTIF(hints.prefetch) AS prefetch,
  COUNTIF(hints.prefetch) / COUNT(0) AS pct_prefetch,
  COUNTIF(hints.preconnect) AS preconnect,
  COUNTIF(hints.preconnect) / COUNT(0) AS pct_preconnect,
  COUNTIF(hints.prerender) AS prerender,
  COUNTIF(hints.prerender) / COUNT(0) AS pct_prerender,
  COUNTIF(hints.`dns-prefetch`) AS dns_prefetch,
  COUNTIF(hints.`dns-prefetch`) / COUNT(0) AS pct_dns_prefetch
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    getResourceHints(payload) AS hints
  FROM
    `httparchive.pages.2020_08_01_*`
  JOIN (
    SELECT
      url
    FROM
      `httparchive.blink_features.features`
    WHERE
      yyyymmdd = '20200801' AND
      feature = 'ServiceWorkerControlledPage'
  )
  USING (url)
)
GROUP BY
  client
