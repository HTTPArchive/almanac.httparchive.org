# Find median lcp AND cls (include other percentiles for interest)
SELECT
  device,
  percentile,
  APPROX_QUANTILES(p75_lcp, 1000)[OFFSET(percentile * 10)] AS lcp,
  APPROX_QUANTILES(p75_cls, 1000)[OFFSET(percentile * 10)] AS cls
FROM
  `chrome-ux-report.materialized.device_summary`,
  UNNEST(GENERATE_ARRAY(1, 100)) AS percentile
WHERE
  date = '2022-06-01' AND
  device IN ('desktop', 'phone')
GROUP BY
  device,
  percentile
