#standardSQL
# 01_02: Distribution of 1P/3P JS bytes
# TODO(rviscomi): Should this be a histogram?
SELECT
  APPROX_QUANTILES(first_party, 100) AS distribution_first_party_js_kbytes,
  APPROX_QUANTILES(third_party, 100) AS distribution_third_party_js_kbytes
FROM (
  SELECT
    ROUND(SUM(IF(NET.HOST(page) = NET.HOST(url), respSize, 0) / 1024), 2) AS first_party,
    ROUND(SUM(IF(NET.HOST(page) != NET.HOST(url), respSize, 0) / 1024), 2) AS third_party
  FROM
    `httparchive.almanac.summary_requests`
  WHERE
    type = 'script'
  GROUP BY
    page)