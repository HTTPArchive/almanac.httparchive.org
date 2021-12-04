#standardSQL
# Third party bytes and requests on SSGs
SELECT
  percentile,
  client,
  APPROX_QUANTILES(requests, 1000)[OFFSET(percentile * 10)] AS requests,
  APPROX_QUANTILES(bytes, 1000)[OFFSET(percentile * 10)] / 1024 AS kbytes
FROM (
  SELECT
    client,
    COUNT(0) AS requests,
    SUM(respSize) AS bytes
  FROM (
    SELECT
      client,
      page,
      url,
      respSize
    FROM
      `httparchive.almanac.requests`
    WHERE
      date = '2021-07-01')
  JOIN (
    SELECT
      _TABLE_SUFFIX AS client,
      url AS page
    FROM
      `httparchive.technologies.2021_07_01_*`
    WHERE
      LOWER(category) = "static site generator" OR
      app = "Next.js" OR
      app = "Nuxt.js")
  USING
    (client, page)
  WHERE
    NET.HOST(url) IN (
      SELECT
        domain
      FROM
        `httparchive.almanac.third_parties`
      WHERE
        date = '2021-07-01' AND
        category != 'hosting')
  GROUP BY
    client,
    page),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
