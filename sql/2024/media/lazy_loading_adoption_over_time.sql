#standardSQL
# How has lazy-loading adoption changed over time?
# copied from https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/2021/resource-hints/imgLazy.sql
# lazy_loading_adoption_over_time.sql

SELECT
  SUBSTR(_TABLE_SUFFIX, 0, 10) AS date,
  IF(ENDS_WITH(_TABLE_SUFFIX, 'desktop'), 'desktop', 'mobile') AS client,
  COUNT(DISTINCT IF(LOWER(attr) = '"lazy"', url, NULL)) / COUNT(DISTINCT url) AS percent
FROM
  `httparchive.pages.*`
LEFT JOIN
  UNNEST(JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload, "$['_img-loading-attr']"), '$')) AS attr
GROUP BY
  date,
  client
ORDER BY
  date DESC,
  client
