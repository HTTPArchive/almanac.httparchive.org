CREATE TEMP FUNCTION getLoadingAttr(attributes STRING) RETURNS STRING LANGUAGE js AS '''
  try {
    const data = JSON.parse(attributes);
    const loadingAttr = data.find(attr => attr["name"] === "loading")
    return loadingAttr.value
  } catch (e) {
    return "";
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
    _TABLE_SUFFIX AS client,
    getLoadingAttr(JSON_EXTRACT(payload, '$._performance.lcp_elem_stats.attributes')) = 'lazy' AS native_lazy,
    hasLazyHeuristics(JSON_EXTRACT(payload, '$._performance.lcp_elem_stats.attributes')) AS custom_lazy
  FROM
    `httparchive.pages.2022_06_01_*`
  WHERE
    # <img> LCP only.
    JSON_EXTRACT_SCALAR(payload, '$._performance.lcp_elem_stats.nodeName') = 'IMG'
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
