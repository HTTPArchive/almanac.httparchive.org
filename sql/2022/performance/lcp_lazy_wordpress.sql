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

WITH lazy AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    getLoadingAttr(JSON_EXTRACT(payload, '$._performance.lcp_elem_stats.attributes')) = 'lazy' AS native_lazy,
    hasLazyHeuristics(JSON_EXTRACT(payload, '$._performance.lcp_elem_stats.attributes')) AS custom_lazy
  FROM
    `httparchive.pages.2022_06_01_*`
  WHERE
    # <img> LCP only.
    JSON_EXTRACT_SCALAR(payload, '$._performance.lcp_elem_stats.nodeName') = 'IMG'
),

wp AS (
  SELECT DISTINCT
    _TABLE_SUFFIX AS client,
    url,
    TRUE AS wordpress
  FROM
    `httparchive.technologies.2022_06_01_*`
  WHERE
    app = 'WordPress'
)


SELECT
  client,
  COUNTIF(wordpress) AS wordpress,
  COUNTIF(native_lazy) AS native_lazy,
  COUNTIF(custom_lazy) AS custom_lazy,
  COUNTIF(wordpress AND native_lazy) / COUNTIF(native_lazy) AS pct_wordpress_native_lazy,
  COUNTIF(wordpress AND custom_lazy) / COUNTIF(custom_lazy) AS pct_wordpress_custom_lazy
FROM
  lazy
LEFT JOIN
  wp
USING (client, url)
GROUP BY
  client
