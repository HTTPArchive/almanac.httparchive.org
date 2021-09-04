# standardSQL
# HTTP/2 % 1st Party versus 3rd Party
SELECT
  percentile,
  client,
  is_third_party,
  ROUND(APPROX_QUANTILES(http2_3_pct, 1000)[OFFSET(percentile * 10)], 2) AS http2_3_pct
FROM (
  SELECT
    client,
    page,
    is_third_party,
    COUNTIF(http_version IN ('HTTP/2', 'HTTP/3', 'QUIC', 'h3-29', 'h3-Q050')) / COUNT(0) AS http2_3_pct
  FROM (
    SELECT
      client,
      page,
      url,
      type,
      respSize,
      protocol AS http_version,
      NET.HOST(url) IN (SELECT domain FROM `httparchive.almanac.third_parties` WHERE date = '2021-07-01') AS is_third_party
    FROM
      `httparchive.almanac.requests`
    WHERE
      date = '2021-07-01')
  WHERE
    type = 'script'
  GROUP BY
    client,
    page,
    is_third_party),
  UNNEST(GENERATE_ARRAY(1, 100)) AS percentile
GROUP BY
  percentile,
  client,
  is_third_party
ORDER BY
  percentile,
  client,
  is_third_party
