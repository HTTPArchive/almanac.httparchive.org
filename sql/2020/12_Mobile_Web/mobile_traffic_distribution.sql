#standardSQL
# Distribution of traffic coming from mobile devices
SELECT
  percentile,
  APPROX_QUANTILES(phoneDensity, 1000)[OFFSET(percentile * 10)] AS pct_traffic_from_mobile,
FROM
  (
    # Since there are more phone sites indexed than desktop, only use sites which have both desktop and phone entries to get more accurate data
    SELECT
      phoneDensity
    FROM
      `chrome-ux-report.materialized.device_summary`
    JOIN (
      SELECT
        origin,
      FROM
        `chrome-ux-report.materialized.device_summary`
      WHERE
        date = '2020-08-01' AND
        device = 'desktop'
    )
    USING (origin)
    WHERE
      date = '2020-08-01' AND
      device = 'phone'
  ),
  UNNEST(GENERATE_ARRAY(1, 100)) AS percentile
GROUP BY
  percentile
ORDER BY
  percentile
