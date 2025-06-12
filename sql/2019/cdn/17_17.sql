#standardSQL
# 17_17: Distribution of # CDNs per page
SELECT
  client,
  APPROX_QUANTILES(cdns, 1000)[OFFSET(100)] AS p10,
  APPROX_QUANTILES(cdns, 1000)[OFFSET(250)] AS p25,
  APPROX_QUANTILES(cdns, 1000)[OFFSET(500)] AS p50,
  APPROX_QUANTILES(cdns, 1000)[OFFSET(750)] AS p75,
  APPROX_QUANTILES(cdns, 1000)[OFFSET(900)] AS p90
FROM (
  SELECT
    client,
    COUNT(DISTINCT _cdn_provider) AS cdns
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2019-07-01'
  GROUP BY
    client,
    page
)
GROUP BY
  client
