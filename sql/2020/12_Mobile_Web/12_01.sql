#standardSQL
# 12_01: 4G, 3G and 2G distribution
SELECT
  _4G,
  _3G,
  _2G
FROM (
  SELECT
    COUNT(0) OVER () AS n,
    ROUND(_4GDensity * 100, 2) AS _4G,
    ROUND(_3GDensity * 100, 2) AS _3G,
    ROUND(_2GDensity * 100, 2) AS _2G,
    ROW_NUMBER() OVER (ORDER BY _4GDensity DESC) AS row
  FROM
    `chrome-ux-report.materialized.metrics_summary`
  WHERE
    yyyymm = 202007 AND
    _4GDensity + _3GDensity + _2GDensity > 0
  ORDER BY
    _4G DESC)
WHERE
  MOD(row, CAST(FLOOR(n / 1000) AS INT64)) = 0
