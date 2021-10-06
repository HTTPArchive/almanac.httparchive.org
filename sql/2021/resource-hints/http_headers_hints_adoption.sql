#standardSQL
# Retrieves resource hints from HTTP headers


CREATE TEMPORARY FUNCTION getResourceHints(payload STRING)
RETURNS STRUCT<preload BOOLEAN, prefetch BOOLEAN, preconnect BOOLEAN, prerender BOOLEAN, `dns-prefetch` BOOLEAN, `modulepreload` BOOLEAN>
LANGUAGE js AS '''
var hints = ['preload', 'prefetch', 'preconnect', 'prerender', 'dns-prefetch', 'modulepreload'];
var re = new RegExp(`(${hints.map(hint => `\\\\b${hint}\\\\b`).join('|')})`, 'ig');
try {
  var $ = JSON.parse(payload);
  return $.response.headers.filter(({name, value}) => name.toLowerCase() == 'link' && re.test(value)).reduce((results, {name, value}) => {
    var hint = value.match(re)[0].toLowerCase();
    results[hint] = true;
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
  COUNTIF(hints.`modulepreload`) AS modulepreload,
  COUNTIF(hints.`modulepreload`) / COUNT(0) AS pct_modulepreload
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    getResourceHints(payload) AS hints
  FROM
    `httparchive.requests.2021_07_01_*`
  WHERE
    payload IS NOT NULL
)
GROUP BY
  client
