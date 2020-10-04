#standardSQL
# ECT distribution
SELECT
  percentile,
  APPROX_QUANTILES(_4GDensity, 1000)[SAFE_ORDINAL(percentile * 10)] AS _4GDensity,
  APPROX_QUANTILES(_3GDensity, 1000)[SAFE_ORDINAL(percentile * 10)] AS _3GDensity,
  APPROX_QUANTILES(_2GDensity, 1000)[SAFE_ORDINAL(percentile * 10)] AS _2GDensity
FROM
  `chrome-ux-report.materialized.metrics_summary`,
  UNNEST([10, 25, 50, 75, 90]) AS percentile
WHERE
  yyyymm = 202007
GROUP BY
  percentile
ORDER BY
  percentile
