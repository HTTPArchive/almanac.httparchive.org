#standardSQL
# 01_04: Distribution of 1P/3P JS requests
SELECT
  percentile,
  client,
  APPROX_QUANTILES(first_party, 1000)[OFFSET(percentile * 10)] AS distribution_first_party_js_kbytes,
  APPROX_QUANTILES(third_party, 1000)[OFFSET(percentile * 10)] AS distribution_third_party_js_kbytes
FROM (
  SELECT
    client,
    COUNTIF(NET.HOST(page) = NET.HOST(url)) AS first_party,
    COUNTIF(NET.HOST(page) != NET.HOST(url)) AS third_party
  FROM
    `httparchive.almanac.summary_requests`
  WHERE
    type = 'script'
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
