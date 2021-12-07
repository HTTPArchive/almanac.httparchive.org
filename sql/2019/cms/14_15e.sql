#standardSQL
# 14_15e: Requests and weight of all content on CMS pages by type
SELECT
  percentile,
  client,
  type,
  APPROX_QUANTILES(requests, 1000)[OFFSET(percentile * 10)] AS requests,
  ROUND(APPROX_QUANTILES(bytes, 1000)[OFFSET(percentile * 10)] / 1024, 2) AS kbytes
FROM (
  SELECT
    client,
    type,
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
  WHERE
    date = '2019-07-01'
  GROUP BY
    client,
    type,
    page),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client,
  type
ORDER BY
  percentile,
  client,
  kbytes DESC
