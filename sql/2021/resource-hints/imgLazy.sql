#standardSQL
SELECT
  SUBSTR(_TABLE_SUFFIX, 0, 10) AS date,
  UNIX_DATE(CAST(REPLACE(SUBSTR(_TABLE_SUFFIX, 0, 10), '_', '-') AS DATE)) * 1000 * 60 * 60 * 24 AS timestamp,
  IF(ENDS_WITH(_TABLE_SUFFIX, 'desktop'), 'desktop', 'mobile') AS client,
  ROUND(COUNT(DISTINCT IF(LOWER(attr) = '"lazy"', url, NULL)) * 100 / COUNT(DISTINCT url), 2) AS percent
FROM
  `httparchive.pages.*`
LEFT JOIN
  UNNEST(JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload, "$['_img-loading-attr']"), '$')) AS attr
GROUP BY
  date,
  timestamp,
  client
ORDER BY
  date DESC,
  client
