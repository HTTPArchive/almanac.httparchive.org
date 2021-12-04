#standardSQL
# 13_07: Distribution of HTML kilobytes per page
SELECT
  _TABLE_SUFFIX AS client,
  percentile,
  APPROX_QUANTILES(bytesHtml, 1000)[OFFSET(percentile * 10)] / 1024 AS requests
FROM
  `httparchive.summary_pages.2021_07_01_*`
JOIN
  `httparchive.technologies.2021_07_01_*`
USING (_TABLE_SUFFIX, url),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
WHERE
  category = 'Ecommerce' AND
  app != 'Cart Functionality' AND
  app != 'Google Analytics Enhanced eCommerce'
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
