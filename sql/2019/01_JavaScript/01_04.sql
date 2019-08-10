#standardSQL
# 01_04: Distribution of 1P/3P JS requests
SELECT
  client,
  APPROX_QUANTILES(first_party, 100) AS distribution_first_party_js_kbytes,
  APPROX_QUANTILES(third_party, 100) AS distribution_third_party_js_kbytes
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
    page)
GROUP BY
  client