#standardSQL
# 13_09c: Requests and weight of third party content on ecom pages, by category
SELECT
  percentile,
  client,
  category,
  APPROX_QUANTILES(requests, 1000)[OFFSET(percentile * 10)] AS requests,
  APPROX_QUANTILES(bytes, 1000)[OFFSET(percentile * 10)] / 1024 AS kbytes
FROM (
  SELECT
    client,
    category,
    COUNT(0) AS requests,
    SUM(respSize) AS bytes
  FROM
    `httparchive.almanac.requests`
  JOIN (
    SELECT DISTINCT
      _TABLE_SUFFIX AS client,
      url AS page
    FROM `httparchive.technologies.2021_07_01_*`
    WHERE
      category = 'Ecommerce' AND (app != 'Cart Functionality' AND app != 'Google Analytics Enhanced eCommerce'))
  USING
    (client, page)
  JOIN
    `httparchive.almanac.third_parties`
  ON
    NET.HOST(url) = domain
  WHERE
    `httparchive.almanac.requests`.date = '2021-07-01'
  GROUP BY
    client,
    category,
    page),

  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client,
  category
ORDER BY
  percentile,
  client,
  requests DESC
