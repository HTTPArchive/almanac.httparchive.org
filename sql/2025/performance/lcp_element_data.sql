CREATE TEMP FUNCTION getLoadingAttr(attributes STRING) RETURNS STRING LANGUAGE js AS '''
  try {
    const data = JSON.parse(attributes);
    const loadingAttr = data.find(attr => attr["name"] === "loading")
    return loadingAttr.value
  } catch (e) {
    return "";
  }
''';

CREATE TEMP FUNCTION getDecodingAttr(attributes STRING) RETURNS STRING LANGUAGE js AS '''
  try {
    const data = JSON.parse(attributes);
    const decodingAttr = data.find(attr => attr["name"] === "decoding")
    return decodingAttr.value
  } catch (e) {
    return "";
  }
''';

CREATE TEMP FUNCTION getFetchPriorityAttr(attributes STRING) RETURNS STRING LANGUAGE js AS '''
  try {
    const data = JSON.parse(attributes);
    const fetchPriorityAttr = data.find(attr => attr["name"] === "fetchpriority")
    return fetchPriorityAttr.value
  } catch (e) {
    return "";
  }
''';

CREATE TEMP FUNCTION getLoadingClasses(attributes STRING) RETURNS STRING LANGUAGE js AS '''
  try {
    const data = JSON.parse(attributes);
    const classes = data.find(attr => attr["name"] === "class").value
    if (classes.indexOf('lazyload') !== -1) {
        return classes
    } else {
        return ""
    }
  } catch (e) {
    return "";
  }
''';

CREATE TEMPORARY FUNCTION getResourceHints(custom_metrics STRING)
RETURNS STRUCT<preload BOOLEAN, prefetch BOOLEAN, preconnect BOOLEAN, prerender BOOLEAN, `dns-prefetch` BOOLEAN, `modulepreload` BOOLEAN>
LANGUAGE js AS '''
var hints = ['preload', 'prefetch', 'preconnect', 'prerender', 'dns-prefetch', 'modulepreload'];
try {
  var $ = JSON.parse(custom_metrics);
  var almanac = $.other.almanac;
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


WITH lcp_stats AS (
  SELECT
    client,
    page,
    JSON_VALUE(custom_metrics.performance.lcp_elem_stats.nodeName) AS nodeName,
    JSON_VALUE(custom_metrics.performance.lcp_elem_stats.url) AS elementUrl,
    CAST(JSON_VALUE(custom_metrics.performance.lcp_elem_stats.size) AS INT64) AS size,
    CAST(JSON_VALUE(custom_metrics.performance.lcp_elem_stats.loadTime) AS FLOAT64) AS loadTime,
    CAST(JSON_VALUE(custom_metrics.performance.lcp_elem_stats.startTime) AS FLOAT64) AS startTime,
    CAST(JSON_VALUE(custom_metrics.performance.lcp_elem_stats.renderTime) AS FLOAT64) AS renderTime,
    TO_JSON_STRING(custom_metrics.performance.lcp_elem_stats.attributes) AS attributes,
    getLoadingAttr(TO_JSON_STRING(custom_metrics.performance.lcp_elem_stats.attributes)) AS loading,
    getDecodingAttr(TO_JSON_STRING(custom_metrics.performance.lcp_elem_stats.attributes)) AS decoding,
    getLoadingClasses(TO_JSON_STRING(custom_metrics.performance.lcp_elem_stats.attributes)) AS classWithLazyload,
    getFetchPriorityAttr(TO_JSON_STRING(custom_metrics.performance.lcp_elem_stats.attributes)) AS fetchPriority,
    getResourceHints(TO_JSON_STRING(custom_metrics)) AS hints
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01' AND
    is_root_page
)

SELECT
  client,
  nodeName,
  COUNT(DISTINCT page) AS pages,
  ANY_VALUE(total) AS total,
  COUNT(DISTINCT page) / ANY_VALUE(total) AS pct,
  COUNTIF(elementUrl != '') AS haveImages,
  COUNTIF(elementUrl != '') / COUNT(DISTINCT page) AS pct_haveImages,
  COUNTIF(loading = 'eager') AS native_eagerload,
  COUNTIF(loading = 'lazy') AS native_lazyload,
  COUNTIF(classWithLazyload != '') AS lazyload_class,
  COUNTIF(classWithLazyload != '' OR loading = 'lazy') AS probably_lazyLoaded,
  COUNTIF(classWithLazyload != '' OR loading = 'lazy') / COUNT(DISTINCT page) AS pct_prob_lazyloaded,
  COUNTIF(decoding = 'async') AS async_decoding,
  COUNTIF(decoding = 'sync') AS sync_decoding,
  COUNTIF(decoding = 'auto') AS auto_decoding,
  COUNTIF(fetchPriority = 'low') AS priority_low,
  COUNTIF(fetchPriority = 'high') AS priority_high,
  COUNTIF(hints.preload) AS preload,
  COUNTIF(hints.preload) / COUNT(0) AS pct_preload
FROM
  lcp_stats
JOIN (
  SELECT
    client,
    COUNT(0) AS total
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01' AND
    is_root_page
  GROUP BY
    client
)
USING (client)
GROUP BY
  client,
  nodeName
HAVING
  pages > 1000
ORDER BY
  pct DESC
