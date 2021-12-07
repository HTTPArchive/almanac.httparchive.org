#standardSQL
# 12_20b: Sites with majority of CLS >=medium, >=large
SELECT
  COUNT(0) AS total_sites,
  COUNTIF((perc_medium_cls + perc_large_cls) >= 50) AS total_majority_medium_cls,
  COUNTIF(perc_large_cls >= 50) AS total_majority_large_cls,
  ROUND(COUNTIF((perc_medium_cls + perc_large_cls) >= 50) * 100 / COUNT(0), 2) AS perc_majority_medium_cls,
  ROUND(COUNTIF(perc_large_cls >= 50) * 100 / COUNT(0), 2) AS perc_majority_large_cls
FROM (
  SELECT
    origin,
    ROUND(SAFE_DIVIDE(large_cls, small_cls + medium_cls + large_cls) * 100, 2) AS perc_large_cls,
    ROUND(SAFE_DIVIDE(medium_cls, small_cls + medium_cls + large_cls) * 100, 2) AS perc_medium_cls
  FROM
    `chrome-ux-report.materialized.device_summary`
  WHERE
    device = 'phone' AND
    yyyymm = '201907'
)
