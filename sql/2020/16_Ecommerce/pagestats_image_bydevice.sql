#standardSQL
# 13_06: Distribution of image stats for 2020
SELECT
  percentile,
  _TABLE_SUFFIX AS client,
  APPROX_QUANTILES(reqImg, 1000)[OFFSET(percentile * 10)] AS image_count,
  ROUND(APPROX_QUANTILES(bytesImg, 1000)[OFFSET(percentile * 10)] / 1024, 2) AS image_kbytes
FROM
  `httparchive.summary_pages.2020_08_01_*`
JOIN
  `httparchive.technologies.2020_08_01_*`
USING (_TABLE_SUFFIX, url),
UNNEST([10, 25, 50, 75, 90]) AS percentile
WHERE
  category = 'Ecommerce' AND 
  (app != 'Cart Functionality' AND 
   app != 'Google Analytics Enhanced eCommerce')
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  order
ORDER BY
  percentile,
  client
