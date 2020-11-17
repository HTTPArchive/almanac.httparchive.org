#standardSQL
# 02_22: Distribution of fonts loaded per page
SELECT
  _TABLE_SUFFIX AS client,
  APPROX_QUANTILES(reqFont, 1000)[OFFSET(100)] AS p10,
  APPROX_QUANTILES(reqFont, 1000)[OFFSET(250)] AS p25,
  APPROX_QUANTILES(reqFont, 1000)[OFFSET(500)] AS p50,
  APPROX_QUANTILES(reqFont, 1000)[OFFSET(750)] AS p75,
  APPROX_QUANTILES(reqFont, 1000)[OFFSET(900)] AS p90
FROM
  `httparchive.summary_pages.2019_07_01_*`
GROUP BY
  client
