#standardSQL
# Median of Largest contentful paint 75% score by month

SELECT
  date,
  device,
  median_p75_lcp
FROM (
  SELECT
    date,
    device,
    PERCENTILE_CONT(p75_lcp, 0.5) OVER(PARTITION BY date, device) AS median_p75_lcp
  FROM
    `chrome-ux-report.materialized.device_summary`
  WHERE
    date >= "2019-08-01"
    AND device IN ('desktop','phone')
)
GROUP BY
  date,
  device,
  median_p75_lcp