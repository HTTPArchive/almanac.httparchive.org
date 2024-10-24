CREATE TEMP FUNCTION isLazyLoaded(attributes STRING) RETURNS BOOLEAN LANGUAGE js AS '''
  try {
    const data = JSON.parse(attributes);
    const loadingAttr = data.find(attr => attr["name"] === "loading")
    return loadingAttr.value == 'lazy'
  } catch (e) {
    return null;
  }
''';

CREATE TEMP FUNCTION hasLazyHeuristics(attributes STRING) RETURNS BOOLEAN LANGUAGE js AS '''
  try {
    const data = JSON.parse(attributes);
    const classes = data.find(attr => attr["name"] === "class").value;
    const hasLazyClasses = classes.indexOf('lazyload') !== -1;
    const hasLazySrc = data.includes(attr => attr["name"] === "data-src");

    return hasLazyClasses || hasLazySrc;
  } catch (e) {
    return false;
  }
''';

WITH lcp_stats AS (
  SELECT
    client,
    isLazyLoaded(JSON_EXTRACT(custom_metrics, '$.performance.lcp_elem_stats.attributes')) AS native_lazy,
    hasLazyHeuristics(JSON_EXTRACT(custom_metrics, '$.performance.lcp_elem_stats.attributes')) AS custom_lazy
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01' AND
    is_root_page AND
    JSON_EXTRACT_SCALAR(custom_metrics, '$.performance.lcp_elem_stats.nodeName') = 'IMG'
)

SELECT
  client,
  COUNT(0) AS total,
  COUNTIF(native_lazy) / COUNT(0) AS pct_native_lazy,
  COUNTIF(custom_lazy) / COUNT(0) AS pct_custom_lazy,
  COUNTIF(custom_lazy OR native_lazy) / COUNT(0) AS pct_either_lazy,
  COUNTIF(custom_lazy AND native_lazy) / COUNT(0) AS pct_both_lazy
FROM
  lcp_stats
GROUP BY
  client
