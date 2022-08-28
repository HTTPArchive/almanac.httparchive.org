#standardSQL
# Percentage adoption of native image lazy loading

SELECT
  CAST(REGEXP_REPLACE(_TABLE_SUFFIX, r'(\d+)_(\d+)_(\d+).*', r'\1-\2-\3') AS DATE) AS date,
  IF(ENDS_WITH(_TABLE_SUFFIX, 'desktop'), 'desktop', 'mobile') AS client,
  COUNT(DISTINCT IF(LOWER(attr) = '"lazy"', url, NULL)) AS sites_using_lazy_loading,
  COUNT(DISTINCT url) AS total_sites,
  COUNT(DISTINCT IF(LOWER(attr) = '"lazy"', url, NULL)) / COUNT(DISTINCT url) AS percent
FROM
  `httparchive.pages.*`
LEFT JOIN
  UNNEST(JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload, "$['_img-loading-attr']"), '$')) AS attr
WHERE
  _TABLE_SUFFIX LIKE '2019_07_01%' OR
  _TABLE_SUFFIX LIKE '2020_08_01%' OR
  _TABLE_SUFFIX LIKE '2021_07_01%' OR
  _TABLE_SUFFIX LIKE '2022_06_01%'
GROUP BY
  date,
  client
ORDER BY
  date DESC,
  client
