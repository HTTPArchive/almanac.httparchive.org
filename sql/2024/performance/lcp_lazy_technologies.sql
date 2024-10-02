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

WITH lazy_tech AS (
  SELECT
    client,
    page,
    isLazyLoaded(JSON_EXTRACT(custom_metrics, '$.performance.lcp_elem_stats.attributes')) AS native_lazy,
    hasLazyHeuristics(JSON_EXTRACT(custom_metrics, '$.performance.lcp_elem_stats.attributes')) AS custom_lazy,
    t.technology
  FROM
    `httparchive.all.pages`,
    UNNEST(technologies) AS t
  WHERE
    date = '2024-06-01' AND
    is_root_page
),

tech_totals AS (
  SELECT
    client,
    technology,
    COUNT(0) AS pages_per_technology
  FROM
    lazy_tech
  GROUP BY
    client,
    technology
)


SELECT
  client,
  technology,
  COUNTIF(native_lazy) AS native_lazy,
  COUNTIF(custom_lazy) AS custom_lazy,
  COUNTIF(native_lazy OR custom_lazy) AS either_lazy,
  COUNT(0) AS pages,
  COUNTIF(native_lazy) / COUNT(0) AS pct_native_lazy,
  COUNTIF(custom_lazy) / COUNT(0) AS pct_custom_lazy,
  COUNTIF(native_lazy OR custom_lazy) / COUNT(0) AS pct_either_lazy
FROM
  lazy_tech
JOIN
  tech_totals
USING
  (client, technology)
GROUP BY
  client,
  technology
HAVING
  pages > 1000 AND
  pct_either_lazy > 0.1
ORDER BY
  either_lazy DESC
