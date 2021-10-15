#standardSQL
# ECT distribution
SELECT
  device,
  percentile,
  APPROX_QUANTILES(_4GDensity / (_4GDensity + _3GDensity + _2GDensity + slow2GDensity + offlineDensity), 1000)[OFFSET(percentile * 10)] AS _4GDensity,
  APPROX_QUANTILES(_3GDensity / (_4GDensity + _3GDensity + _2GDensity + slow2GDensity + offlineDensity), 1000)[OFFSET(percentile * 10)] AS _3GDensity,
  APPROX_QUANTILES(_2GDensity / (_4GDensity + _3GDensity + _2GDensity + slow2GDensity + offlineDensity), 1000)[OFFSET(percentile * 10)] AS _2GDensity,
  APPROX_QUANTILES(slow2GDensity / (_4GDensity + _3GDensity + _2GDensity + slow2GDensity + offlineDensity), 1000)[OFFSET(percentile * 10)] AS slow2GDensity,
  APPROX_QUANTILES(offlineDensity / (_4GDensity + _3GDensity + _2GDensity + slow2GDensity + offlineDensity), 1000)[OFFSET(percentile * 10)] AS offlineDensity
FROM
  `chrome-ux-report.materialized.device_summary`,
  UNNEST(GENERATE_ARRAY(1, 100)) AS percentile
WHERE
  date = '2021-07-01'
GROUP BY
  device,
  percentile
ORDER BY
  device,
  percentile
