#standardSQL
# 01_02a: Distribution of 1P/3P JS bytes
SELECT
  percentile,
  ROUND(APPROX_QUANTILES(first_party, 1000)[OFFSET(percentile * 10)], 2) AS first_party_js_kbytes,
  ROUND(APPROX_QUANTILES(third_party, 1000)[OFFSET(percentile * 10)], 2) AS third_party_js_kbytes
FROM (
  SELECT
    SUM(IF(NET.HOST(page) = NET.HOST(url), respSize, 0) / 1024) AS first_party,
    SUM(IF(NET.HOST(page) != NET.HOST(url), respSize, 0) / 1024) AS third_party
  FROM
    `httparchive.almanac.summary_requests`
  WHERE
    type = 'script'
  GROUP BY
    page),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile
ORDER BY
  percentile