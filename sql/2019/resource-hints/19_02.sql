#standardSQL
# 19_02: Distribution of number of times each hint is used per site.
CREATE TEMPORARY FUNCTION getResourceHints(payload STRING)
RETURNS STRUCT<preload INT64, prefetch INT64, preconnect INT64, prerender INT64, `dns-prefetch` INT64>
LANGUAGE js AS '''
var hints = ['preload', 'prefetch', 'preconnect', 'prerender', 'dns-prefetch'];
try {
  var $ = JSON.parse(payload);
  var almanac = JSON.parse($._almanac);
  return hints.reduce((results, hint) => {
    // Null values are omitted from BigQuery aggregations.
    // This means only pages with at least one hint are considered.
    results[hint] = almanac['link-nodes'].filter(link => link.rel.toLowerCase() == hint).length || null;
    return results;
  }, {});
} catch (e) {
  return hints.reduce((results, hint) => {
    results[hint] = null;
    return results;
  }, {});
}
''';

SELECT
  client,
  APPROX_QUANTILES(hints.preload, 1000)[OFFSET(500)] AS median_preload,
  APPROX_QUANTILES(hints.prefetch, 1000)[OFFSET(500)] AS median_prefetch,
  APPROX_QUANTILES(hints.preconnect, 1000)[OFFSET(500)] AS median_preconnect,
  APPROX_QUANTILES(hints.prerender, 1000)[OFFSET(500)] AS median_prerender,
  APPROX_QUANTILES(hints.`dns-prefetch`, 1000)[OFFSET(500)] AS median_dns_prefetch,
  APPROX_QUANTILES(hints.preload, 1000)[OFFSET(900)] AS p90_preload,
  APPROX_QUANTILES(hints.prefetch, 1000)[OFFSET(900)] AS p90_prefetch,
  APPROX_QUANTILES(hints.preconnect, 1000)[OFFSET(900)] AS p90_preconnect,
  APPROX_QUANTILES(hints.prerender, 1000)[OFFSET(900)] AS p90_prerender,
  APPROX_QUANTILES(hints.`dns-prefetch`, 1000)[OFFSET(900)] AS p90_dns_prefetch
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    getResourceHints(payload) AS hints
  FROM
    `httparchive.pages.2019_07_01_*`)
GROUP BY
  client
