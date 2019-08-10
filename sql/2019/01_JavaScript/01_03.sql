#standardSQL
# 01_03: Distribution of JS requests
SELECT
  _TABLE_SUFFIX AS client,
  APPROX_QUANTILES(reqJs, 100) AS distribution_js_reqs
FROM
  `httparchive.summary_pages.2019_07_01_*`
GROUP BY
  client