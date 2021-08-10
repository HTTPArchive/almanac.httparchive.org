#standardSQL
# Distribution of traffic coming from mobile devices
SELECT
  percentile,
  APPROX_QUANTILES(phoneDensity, 1000)[OFFSET(percentile * 10)] AS pct_traffic_from_mobile
FROM
  `chrome-ux-report.materialized.device_summary`,
  UNNEST(GENERATE_ARRAY(1, 100)) AS percentile
WHERE
  date = '2020-08-01' AND
  device = 'phone'
GROUP BY
  percentile
ORDER BY
  percentile
