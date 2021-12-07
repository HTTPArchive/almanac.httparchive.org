#standardSQL
# 13_07: Distribution of HTML kilobytes per page
SELECT
  _TABLE_SUFFIX AS client,
  ROUND(APPROX_QUANTILES(bytesHtml, 1000)[OFFSET(100)] / 1024, 2) AS p10,
  ROUND(APPROX_QUANTILES(bytesHtml, 1000)[OFFSET(250)] / 1024, 2) AS p25,
  ROUND(APPROX_QUANTILES(bytesHtml, 1000)[OFFSET(500)] / 1024, 2) AS p50,
  ROUND(APPROX_QUANTILES(bytesHtml, 1000)[OFFSET(750)] / 1024, 2) AS p75,
  ROUND(APPROX_QUANTILES(bytesHtml, 1000)[OFFSET(900)] / 1024, 2) AS p90
FROM
  `httparchive.summary_pages.2020_08_01_*`
JOIN
  `httparchive.technologies.2020_08_01_*`
USING (_TABLE_SUFFIX, url)
WHERE
  category = 'Ecommerce' AND
  (app != 'Cart Functionality' AND
   app != 'Google Analytics Enhanced eCommerce')
GROUP BY
  client
