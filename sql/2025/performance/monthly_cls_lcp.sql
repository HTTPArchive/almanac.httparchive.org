SELECT
  date,
  device,
  COUNTIF(fast_lcp / (fast_lcp + avg_lcp + slow_lcp) >= 0.75) / COUNTIF(fast_lcp IS NOT NULL) AS pct_good_lcp,
  COUNTIF(small_cls / (small_cls + medium_cls + large_cls) >= 0.75) / COUNTIF(small_cls IS NOT NULL) AS pct_good_cls
FROM
  `chrome-ux-report.materialized.device_summary`
WHERE
  date BETWEEN '2022-01-01' AND '2025-06-01' AND
  device IN ('desktop', 'phone')
GROUP BY
  date,
  device
ORDER BY
  date,
  device
