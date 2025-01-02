# standardSQL
# HTTP/2 3rd Party by Types
SELECT
  percentile,
  client,
  category,
  APPROX_QUANTILES(http2_3_pct, 1000)[OFFSET(percentile * 10)] AS http2_3_pct
FROM (
  SELECT
    client,
    page,
    category,
    COUNTIF(LOWER(http_version) IN ('http/2', 'http/3', 'quic', 'h3-29', 'h3-q050')) / COUNT(0) AS http2_3_pct
  FROM (
    SELECT
      client,
      page,
      url,
      category,
      protocol AS http_version
    FROM
      `httparchive.almanac.requests` r,
      `httparchive.almanac.third_parties` tp
    WHERE
      r.date = '2021-07-01' AND
      tp.date = '2021-07-01' AND
      NET.HOST(url) = domain
  )
  GROUP BY
    client,
    page,
    category
),
  UNNEST([5, 10, 20, 30, 40, 50, 60, 70, 80, 90, 95, 100]) AS percentile
GROUP BY
  percentile,
  client,
  category
ORDER BY
  percentile,
  client,
  category
