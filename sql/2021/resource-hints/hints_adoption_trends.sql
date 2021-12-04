#standardSQL
# trends of sites that use each type of resource hint.

CREATE TEMPORARY FUNCTION getResourceHints(payload STRING)
RETURNS STRUCT<preload BOOLEAN, prefetch BOOLEAN, preconnect BOOLEAN, prerender BOOLEAN, `dns-prefetch` BOOLEAN, `modulepreload` BOOLEAN>
LANGUAGE js AS '''
var hints = ['preload', 'prefetch', 'preconnect', 'prerender', 'dns-prefetch', 'modulepreload'];
try {
  var $ = JSON.parse(payload);
  var almanac = JSON.parse($._almanac);
  return hints.reduce((results, hint) => {
    if (almanac['link-nodes'].nodes) {
      results[hint] = !!almanac['link-nodes'].nodes.find(link => link.rel.toLowerCase() == hint);
    } else {
      // in 2019 we did not have the `.nodes property`
      results[hint] = !!almanac['link-nodes'].find(link => link.rel.toLowerCase() == hint);
    }
    return results;
  }, {});
} catch (e) {
  return hints.reduce((results, hint) => {
    results[hint] = false;
    return results;
  }, {});
}
''';

WITH pages AS (
  SELECT
    '2019' AS year,
    _TABLE_SUFFIX AS client,
    *
  FROM
    `httparchive.pages.2019_07_01_*`
  UNION ALL
  SELECT
    '2020' AS year,
    _TABLE_SUFFIX AS client,
    *
  FROM
    `httparchive.pages.2020_08_01_*`
  UNION ALL
  SELECT
    '2021' AS year,
    _TABLE_SUFFIX AS client,
    *
  FROM
    `httparchive.pages.2021_07_01_*`
)

SELECT
  year,
  client,
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
    client,
    year,
    getResourceHints(payload) AS hints
  FROM
    pages)
GROUP BY
  year,
  client
ORDER BY
  year,
  client
