#standardSQL
# 01_02a: Distribution of 1P/3P JS bytes
SELECT
  percentile,
  ROUND(APPROX_QUANTILES(first_party, 1000)[OFFSET(percentile * 10)], 2) AS first_party_js_kbytes,
  ROUND(APPROX_QUANTILES(third_party, 1000)[OFFSET(percentile * 10)], 2) AS third_party_js_kbytes
FROM (
  SELECT
    SUM(IF(NOT is_third_party, respSize, 0) / 1024) AS first_party,
    SUM(IF(is_third_party, respSize, 0) / 1024) AS third_party
  FROM (
    SELECT
      page,
      url,
      type,
      respSize,
      NET.HOST(url) IN (SELECT domain FROM `httparchive.almanac.third_parties`) AS is_third_party
    FROM
      `httparchive.almanac.summary_requests`
    WHERE
      date = '2019-07-01'
  )
  WHERE
    type = 'script'
  GROUP BY
    page
),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile
ORDER BY
  percentile
