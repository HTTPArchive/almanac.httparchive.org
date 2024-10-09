#standardSQL
# Third party bytes and requests on CMSs
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
      date = '2020-08-01'
  )
  JOIN (
    SELECT
      _TABLE_SUFFIX AS client,
      url AS page
    FROM
      `httparchive.technologies.2020_08_01_*`
    WHERE
      category = 'CMS'
  )
  USING (client, page)
  WHERE
    NET.HOST(url) IN (
      SELECT
        domain
      FROM
        `httparchive.almanac.third_parties`
      WHERE
        date = '2020-08-01' AND
        category != 'hosting'
    )
  GROUP BY
    client,
    page
),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
