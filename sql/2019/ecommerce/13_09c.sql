#standardSQL
# 13_09c: Requests and weight of third party content on ecom pages, by category
SELECT
  percentile,
  client,
  category,
  APPROX_QUANTILES(requests, 1000)[OFFSET(percentile * 10)] AS requests,
  ROUND(APPROX_QUANTILES(bytes, 1000)[OFFSET(percentile * 10)] / 1024, 2) AS kbytes
FROM (
  SELECT
    client,
    category,
    COUNT(0) AS requests,
    SUM(respSize) AS bytes
  FROM
    `httparchive.almanac.summary_requests` sr
  JOIN (
    SELECT _TABLE_SUFFIX AS client, url AS page
    FROM `httparchive.technologies.2019_07_01_*`
    WHERE category = 'Ecommerce')
  USING
    (client, page)
  JOIN
    `httparchive.almanac.third_parties` tp
  ON
    NET.HOST(url) = domain
  WHERE
    sr.date = '2019-07-01' AND
    sr.date = tp.date
  GROUP BY
    client,
    category,
    page),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client,
  category
ORDER BY
  percentile,
  client,
  requests DESC
