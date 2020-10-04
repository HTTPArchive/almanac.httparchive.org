#standardSQL
# Distribution of traffic coming from mobile devices
SELECT
  percentile,
  APPROX_QUANTILES(phoneDensity, 1000)[SAFE_ORDINAL(percentile * 10)] AS pct_traffic_from_mobile,
FROM
  `chrome-ux-report.materialized.device_summary`,
  UNNEST(GENERATE_ARRAY(1, 100)) AS percentile
WHERE
  yyyymm = 202007
GROUP BY
  percentile
ORDER BY
  percentile
