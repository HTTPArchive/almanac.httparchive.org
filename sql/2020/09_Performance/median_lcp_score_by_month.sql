#standardSQL
# Median of Largest contentful paint 75% score by month


SELECT
  date,
  device,
  APPROX_QUANTILES(p75_lcp, 2 RESPECT NULLS)[OFFSET(1)] AS approx_median_p75_lcp,
FROM
  `chrome-ux-report.materialized.device_summary`
WHERE
  date >= "2019-09-01"
  AND date <= "2020-09-30"
  AND device IN ('desktop','phone')
GROUP BY
  date,
  device