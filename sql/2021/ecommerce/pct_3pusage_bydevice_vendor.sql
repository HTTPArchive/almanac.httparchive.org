#standardSQL
# 13_09b: Requests and weight of third party content per app
SELECT
  client,
  app,
  percentile,
  COUNT(0) AS pages,
  APPROX_QUANTILES(requests, 1000)[OFFSET(percentile * 10)] AS requests,
  APPROX_QUANTILES(bytes, 1000)[OFFSET(percentile * 10)] / 1024 AS kbytes
FROM (
  SELECT
    client,
    app,
    COUNT(0) AS requests,
    SUM(respSize) AS bytes
  FROM
    `httparchive.almanac.requests`
  JOIN (
    SELECT _TABLE_SUFFIX AS client, url AS page, app
    FROM `httparchive.technologies.2021_07_01_*`
    WHERE category = 'Ecommerce'
  )
  USING (client, page)
  WHERE
    date = '2021-07-01' AND
    NET.HOST(url) IN (
      SELECT domain
      FROM `httparchive.almanac.third_parties`
      WHERE date = '2021-07-01' AND category != 'hosting'
    )
  GROUP BY
    client,
    app,
    page
),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  client,
  app,
  percentile
ORDER BY
  pages DESC,
  client,
  percentile
