#standardSQL
# 13_06: Distribution of image stats for 2020
SELECT
  percentile,
  _TABLE_SUFFIX AS client,
  APPROX_QUANTILES(reqImg, 1000)[OFFSET(percentile * 10)] AS image_count,
  ROUND(APPROX_QUANTILES(bytesImg, 1000)[OFFSET(percentile * 10)] / 1024, 2) AS image_kbytes
FROM
  `httparchive.summary_pages.2020_08_01_*`
JOIN (
  SELECT DISTINCT
    _TABLE_SUFFIX,
    url
  FROM `httparchive.technologies.2020_08_01_*`
  WHERE category = 'Ecommerce'
)
USING (_TABLE_SUFFIX, url),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
