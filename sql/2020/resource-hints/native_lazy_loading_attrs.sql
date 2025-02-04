#standardSQL
# 21_12b: Values of the 'loading' attribute
SELECT
  _TABLE_SUFFIX AS client,
  loading,
  COUNT(DISTINCT url) AS freq,
  total,
  COUNT(DISTINCT url) / total AS pct
FROM
  `httparchive.pages.2020_08_01_*`,
  UNNEST(JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload, "$['_img-loading-attr']"), '$')) AS loading
JOIN (
  SELECT _TABLE_SUFFIX, COUNT(0) AS total FROM `httparchive.pages.2020_08_01_*` GROUP BY _TABLE_SUFFIX
)
USING (_TABLE_SUFFIX)
GROUP BY
  client,
  loading,
  total
HAVING
  freq >= 10
ORDER BY
  freq DESC
