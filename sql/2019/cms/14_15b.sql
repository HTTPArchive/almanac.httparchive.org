#standardSQL
# 14_15b: Requests and weight of third party content per app
SELECT
  client,
  app,
  percentile,
  COUNT(0) AS pages,
  APPROX_QUANTILES(requests, 1000)[OFFSET(percentile * 10)] AS requests,
  ROUND(APPROX_QUANTILES(bytes, 1000)[OFFSET(percentile * 10)] / 1024, 2) AS kbytes
FROM (
  SELECT
    client,
    app,
    COUNT(0) AS requests,
    SUM(respSize) AS bytes
  FROM
    `httparchive.almanac.summary_requests`
  JOIN (
    SELECT _TABLE_SUFFIX AS client, url AS page, app
    FROM `httparchive.technologies.2019_07_01_*`
    WHERE category = 'CMS'
  )
  USING (client, page)
  WHERE
    date = '2019-07-01' AND
    NET.HOST(url) IN (SELECT domain FROM `httparchive.almanac.third_parties` WHERE date = '2019-07-01')
  GROUP BY
    client,
    app,
    page
),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  client,
  app,
  percentile
ORDER BY
  pages DESC,
  client,
  percentile
