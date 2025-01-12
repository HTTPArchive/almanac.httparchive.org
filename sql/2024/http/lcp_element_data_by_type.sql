CREATE TEMP FUNCTION getLoadingAttr(attributes STRING) RETURNS STRING LANGUAGE js AS '''
  try {
    const data = JSON.parse(attributes);
    const loadingAttr = data.find(attr => attr['name'] === 'loading')
    return loadingAttr.value
  } catch (e) {
    return '';
  }
''';

CREATE TEMP FUNCTION getDecodingAttr(attributes STRING) RETURNS STRING LANGUAGE js AS '''
  try {
    const data = JSON.parse(attributes);
    const decodingAttr = data.find(attr => attr['name'] === 'decoding')
    return decodingAttr.value
  } catch (e) {
    return '';
  }
''';

CREATE TEMP FUNCTION getFetchPriorityAttr(attributes STRING) RETURNS STRING LANGUAGE js AS '''
  try {
    const data = JSON.parse(attributes);
    const fetchPriorityAttr = data.find(attr => attr['name'] === 'fetchpriority')
    return fetchPriorityAttr.value
  } catch (e) {
    return '';
  }
''';

CREATE TEMP FUNCTION getLoadingClasses(attributes STRING) RETURNS STRING LANGUAGE js AS '''
  try {
    const data = JSON.parse(attributes);
    const classes = data.find(attr => attr['name'] === 'class').value
    if (classes.indexOf('lazyload') !== -1) {
        return classes
    } else {
        return ''
    }
  } catch (e) {
    return '';
  }
''';

WITH lcp_stats AS (
  SELECT
    client,
    page,
    JSON_EXTRACT_SCALAR(custom_metrics, '$.performance.lcp_elem_stats.nodeName') AS nodeName,
    JSON_EXTRACT_SCALAR(custom_metrics, '$.performance.lcp_elem_stats.url') AS elementUrl,
    CAST(JSON_EXTRACT_SCALAR(custom_metrics, '$.performance.lcp_elem_stats.size') AS INT64) AS size,
    CAST(JSON_EXTRACT_SCALAR(custom_metrics, '$.performance.lcp_elem_stats.loadTime') AS FLOAT64) AS loadTime,
    CAST(JSON_EXTRACT_SCALAR(custom_metrics, '$.performance.lcp_elem_stats.startTime') AS FLOAT64) AS startTime,
    CAST(JSON_EXTRACT_SCALAR(custom_metrics, '$.performance.lcp_elem_stats.renderTime') AS FLOAT64) AS renderTime,
    JSON_EXTRACT(custom_metrics, '$.performance.lcp_elem_stats.attributes') AS attributes,
    getLoadingAttr(JSON_EXTRACT(custom_metrics, '$.performance.lcp_elem_stats.attributes')) AS loading,
    getDecodingAttr(JSON_EXTRACT(custom_metrics, '$.performance.lcp_elem_stats.attributes')) AS decoding,
    getLoadingClasses(JSON_EXTRACT(custom_metrics, '$.performance.lcp_elem_stats.attributes')) AS classWithLazyload,
    getFetchPriorityAttr(JSON_EXTRACT(custom_metrics, '$.performance.lcp_elem_stats.attributes')) AS fetchPriority,
    LOWER(JSON_EXTRACT_SCALAR(custom_metrics, '$.performance.lcp_resource.initialPriority')) AS initalPriority,
    LOWER(JSON_EXTRACT_SCALAR(custom_metrics, '$.performance.lcp_resource.priority')) AS priority,
    CAST(JSON_EXTRACT(custom_metrics, '$.performance.is_lcp_preloaded') AS BOOL) AS preloaded
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01' AND
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
  COUNTIF(fetchPriority = 'low') AS fetchpriority_low,
  COUNTIF(fetchPriority = 'high') AS fetchpriority_high,
  COUNTIF(fetchPriority = 'low') / COUNT(DISTINCT page) AS pct_fetchpriority_low,
  COUNTIF(fetchPriority = 'high') / COUNT(DISTINCT page) AS pct_fetchpriority_high,
  COUNTIF(loading = 'lazy' AND fetchPriority = 'high') AS native_lazyload_and_fetch_priority,
  COUNTIF(loading = 'lazy' AND fetchPriority = 'high') / COUNT(DISTINCT page) AS pct_native_lazyload_and_fetch_priority,
  COUNTIF(initalPriority = 'low') AS inital_priority_low,
  COUNTIF(initalPriority = 'medium') AS inital_priority_medium,
  COUNTIF(initalPriority = 'high') AS inital_priority_high_and_fetchpriority,
  COUNTIF(initalPriority = 'high' AND fetchPriority = 'high') AS inital_priority_high,
  COUNTIF(initalPriority = 'low') / COUNT(DISTINCT page) AS pct_inital_priority_low,
  COUNTIF(initalPriority = 'medium') / COUNT(DISTINCT page) AS pct_inital_priority_medium,
  COUNTIF(initalPriority = 'high') / COUNT(DISTINCT page) AS pct_inital_priority_high,
  COUNTIF(initalPriority = 'high' AND fetchPriority = 'high') / COUNT(DISTINCT page) AS pct_inital_priority_high_and_fetchpriority,
  COUNTIF(preloaded) AS preload,
  COUNTIF(preloaded) / COUNT(DISTINCT page) AS pct_preload
FROM
  lcp_stats
JOIN (
  SELECT
    client,
    COUNT(0) AS total
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01' AND
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
