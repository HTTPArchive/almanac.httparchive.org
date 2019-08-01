#standardSQL
# 01_03: Distribution of JS requests
# TODO(rviscomi): Should this be a histogram?
SELECT
  APPROX_QUANTILES(reqJs, 100) AS distribution_js_reqs
FROM
  `httparchive.summary_pages.2019_07_01_*`