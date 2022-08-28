# Find median lcp AND cls (include other percentiles for interest)
SELECT
  device,
  APPROX_QUANTILES(p75_lcp, 1000)[OFFSET(10 * 10)] AS p10_lcp,
  APPROX_QUANTILES(p75_lcp, 1000)[OFFSET(25 * 10)] AS p25_lcp,
  APPROX_QUANTILES(p75_lcp, 1000)[OFFSET(50 * 10)] AS median_lcp,
  APPROX_QUANTILES(p75_lcp, 1000)[OFFSET(75 * 10)] AS p75_lcp,
  APPROX_QUANTILES(p75_lcp, 1000)[OFFSET(90 * 10)] AS p90_lcp,
  APPROX_QUANTILES(p75_cls, 1000)[OFFSET(10 * 10)] AS p10_cls,
  APPROX_QUANTILES(p75_cls, 1000)[OFFSET(25 * 10)] AS p25_cls,
  APPROX_QUANTILES(p75_cls, 1000)[OFFSET(50 * 10)] AS median_cls,
  APPROX_QUANTILES(p75_cls, 1000)[OFFSET(75 * 10)] AS p75_cls,
  APPROX_QUANTILES(p75_cls, 1000)[OFFSET(90 * 10)] AS p90_cls
FROM
  `chrome-ux-report.materialized.device_summary`
WHERE
  date = '2022-06-01' AND
  device IN ('desktop', 'phone')
GROUP BY
  device
