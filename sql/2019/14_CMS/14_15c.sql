#standardSQL
# 14_15c: Requests and weight of third party content on CMS pages, by category
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
    `httparchive.almanac.summary_requests`
  JOIN (
    SELECT _TABLE_SUFFIX AS client, url AS page
    FROM `httparchive.technologies.2019_07_01_*`
    WHERE category = 'CMS')
  USING
    (client, page)
  JOIN
    `httparchive.almanac.third_parties`
  ON
    NET.HOST(url) = domain
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