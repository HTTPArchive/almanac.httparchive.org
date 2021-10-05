#standardSQL
# 13_07: Distribution of HTML kilobytes per page
SELECT
  _TABLE_SUFFIX AS client,
  APPROX_QUANTILES(bytesHtml, 1000)[OFFSET(100)] / 1024 AS p10,
  APPROX_QUANTILES(bytesHtml, 1000)[OFFSET(250)] / 1024 AS p25,
  APPROX_QUANTILES(bytesHtml, 1000)[OFFSET(500)] / 1024 AS p50,
  APPROX_QUANTILES(bytesHtml, 1000)[OFFSET(750)] / 1024 AS p75,
  APPROX_QUANTILES(bytesHtml, 1000)[OFFSET(900)] / 1024 AS p90,
  APPROX_QUANTILES(bytesHtml, 1000)[OFFSET(1000)] / 1024 AS p100
FROM
  `httparchive.summary_pages.2021_07_01_*`
JOIN
  `httparchive.technologies.2021_07_01_*`
USING (_TABLE_SUFFIX, url)
WHERE
  category = 'Ecommerce' AND
  (app != 'Cart Functionality' AND
   app != 'Google Analytics Enhanced eCommerce')
GROUP BY
  client
