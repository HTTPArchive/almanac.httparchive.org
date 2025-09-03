CREATE TEMP FUNCTION getLoadingAttr(attributes JSON) RETURNS STRING LANGUAGE js AS '''
  try {
    const loadingAttr = attributes.find(attr => attr["name"] === "loading")
    return loadingAttr.value
  } catch (e) {
    return "";
  }
''';

CREATE TEMP FUNCTION getDecodingAttr(attributes JSON) RETURNS STRING LANGUAGE js AS '''
  try {
    const decodingAttr = attributes.find(attr => attr["name"] === "decoding")
    return decodingAttr.value
  } catch (e) {
    return "";
  }
''';

CREATE TEMP FUNCTION getFetchPriorityAttr(attributes JSON) RETURNS STRING LANGUAGE js AS '''
  try {
    const fetchPriorityAttr = attributes.find(attr => attr["name"] === "fetchpriority")
    return fetchPriorityAttr.value
  } catch (e) {
    return "";
  }
''';

CREATE TEMP FUNCTION getLoadingClasses(attributes JSON) RETURNS STRING LANGUAGE js AS '''
  try {
    const classes = attributes.find(attr => attr["name"] === "class").value
    if (classes.indexOf('lazyload') !== -1) {
        return classes
    } else {
        return ""
    }
  } catch (e) {
    return "";
  }
''';

WITH
lcp_stats AS (
  SELECT
    client,
    page AS url,
    JSON_VALUE(custom_metrics.performance.lcp_elem_stats.nodeName) AS nodeName,
    JSON_VALUE(custom_metrics.performance.lcp_elem_stats.url) AS elementUrl,
    CAST(JSON_VALUE(custom_metrics.performance.lcp_elem_stats.size) AS INT64) AS size,
    CAST(JSON_VALUE(custom_metrics.performance.lcp_elem_stats.loadTime) AS FLOAT64) AS loadTime,
    CAST(JSON_VALUE(custom_metrics.performance.lcp_elem_stats.startTime) AS FLOAT64) AS startTime,
    CAST(JSON_VALUE(custom_metrics.performance.lcp_elem_stats.renderTime) AS FLOAT64) AS renderTime,
    custom_metrics.performance.lcp_elem_stats.attributes AS attributes,
    getLoadingAttr(custom_metrics.performance.lcp_elem_stats.attributes) AS loading,
    getDecodingAttr(custom_metrics.performance.lcp_elem_stats.attributes) AS decoding,
    getLoadingClasses(custom_metrics.performance.lcp_elem_stats.attributes) AS classWithLazyload,
    getFetchPriorityAttr(custom_metrics.performance.lcp_elem_stats.attributes) AS fetchPriority
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01' AND
    is_root_page
)

SELECT
  client,
  nodeName,
  COUNT(DISTINCT url) AS pages,
  ANY_VALUE(total) AS total,
  COUNT(DISTINCT url) / ANY_VALUE(total) AS pct,
  COUNTIF(elementUrl != '') AS haveImages,
  COUNTIF(elementUrl != '') / COUNT(DISTINCT url) AS pct_haveImages,
  COUNTIF(loading = 'eager') AS native_eagerload,
  COUNTIF(loading = 'lazy') AS native_lazyload,
  COUNTIF(classWithLazyload != '') AS lazyload_class,
  COUNTIF(classWithLazyload != '' OR loading = 'lazy') AS probably_lazyLoaded,
  COUNTIF(classWithLazyload != '' OR loading = 'lazy') / COUNT(DISTINCT url) AS pct_prob_lazyloaded,
  COUNTIF(decoding = 'async') AS async_decoding,
  COUNTIF(decoding = 'sync') AS sync_decoding,
  COUNTIF(decoding = 'auto') AS auto_decoding,
  COUNTIF(fetchPriority = 'low') AS priority_low,
  COUNTIF(fetchPriority = 'low') / COUNT(DISTINCT url) AS pct_priority_low,
  COUNTIF(fetchPriority = 'high') AS priority_high,
  COUNTIF(fetchPriority = 'high') / COUNT(DISTINCT url) AS pct_priority_high
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
