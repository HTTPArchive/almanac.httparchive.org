#standardSQL
# 14_15d: Requests and weight of all content on CMS pages
SELECT
  percentile,
  client,
  APPROX_QUANTILES(requests, 1000)[OFFSET(percentile * 10)] AS requests,
  ROUND(APPROX_QUANTILES(bytes, 1000)[OFFSET(percentile * 10)] / 1024 / 1024, 2) AS mbytes
FROM (
  SELECT
    client,
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
  GROUP BY
    client,
    page),
UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client