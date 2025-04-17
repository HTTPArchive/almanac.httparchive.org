#standardSQL
# LCP element node details
# How many LCPs had images? (either <img>s or as background images)?
# How many of those <img>s were lazy-loaded (anti-pattern!)
# lcp_element_data.sql

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


WITH
lcp_stats AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    JSON_EXTRACT_SCALAR(payload, '$._performance.lcp_elem_stats.nodeName') AS nodeName,
    JSON_EXTRACT_SCALAR(payload, '$._performance.lcp_elem_stats.url') AS elementUrl,
    CAST(JSON_EXTRACT_SCALAR(payload, '$._performance.lcp_elem_stats.size') AS INT64) AS size,
    CAST(JSON_EXTRACT_SCALAR(payload, '$._performance.lcp_elem_stats.loadTime') AS FLOAT64) AS loadTime,
    CAST(JSON_EXTRACT_SCALAR(payload, '$._performance.lcp_elem_stats.startTime') AS FLOAT64) AS startTime,
    CAST(JSON_EXTRACT_SCALAR(payload, '$._performance.lcp_elem_stats.renderTime') AS FLOAT64) AS renderTime,
    JSON_EXTRACT(payload, '$._performance.lcp_elem_stats.attributes') AS attributes,
    getLoadingAttr(JSON_EXTRACT(payload, '$._performance.lcp_elem_stats.attributes')) AS loading,
    getDecodingAttr(JSON_EXTRACT(payload, '$._performance.lcp_elem_stats.attributes')) AS decoding,
    getLoadingClasses(JSON_EXTRACT(payload, '$._performance.lcp_elem_stats.attributes')) AS classWithLazyload
  FROM
    `httparchive.pages.2024_06_01_*`
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
  COUNTIF(decoding = 'auto') AS auto_decoding
FROM
  lcp_stats
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2024_06_01_*`
  GROUP BY
    _TABLE_SUFFIX
)
USING (client)
GROUP BY
  client,
  nodeName
HAVING
  pages > 1000
ORDER BY
  pct DESC
