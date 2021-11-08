#standardSQL
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
