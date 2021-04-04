#standardSQL
# 12_20: Cumulative layout shift distribution
SELECT
  * EXCEPT (row)
FROM (
  SELECT
    ROW_NUMBER() OVER () AS row,
    ROUND(SAFE_DIVIDE(small_cls, small_cls + medium_cls + large_cls) * 100, 2) AS small_cls,
    ROUND(SAFE_DIVIDE(medium_cls, small_cls + medium_cls + large_cls) * 100, 2) AS medium_cls,
    ROUND(SAFE_DIVIDE(large_cls, small_cls + medium_cls + large_cls) * 100, 2) AS large_cls
  FROM
    `chrome-ux-report.materialized.device_summary`
  WHERE
    device = 'phone' AND
    yyyymm = '201907'
  ORDER BY
    small_cls DESC)
WHERE
  MOD(row, 5229) = 0
