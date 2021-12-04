#standardSQL
# Median of Largest contentful paint 75% score by month

SELECT
  device,
  date,
  APPROX_QUANTILES(p75_lcp, 1000 RESPECT NULLS)[OFFSET(500)] AS median_p75_lcp
FROM
  `chrome-ux-report.materialized.device_summary`
WHERE
  date >= '2019-09-01' AND
  date <= '2020-08-01' AND
  device IN ('desktop', 'phone')
GROUP BY
  device,
  date
