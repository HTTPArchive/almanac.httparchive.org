#standardSQL
# Histogram of unused JS bytes per page

SELECT
  IF(unused_js_kbytes <= 1000, CEIL(unused_js_kbytes / 20) * 20, 1000) AS unused_js_kbytes,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY 0) AS pct,
  COUNT(0) AS pages,
  SUM(COUNT(0)) OVER (PARTITION BY 0) AS total,
  --only interested in last max one as a 'surprising metric'
  MAX(unused_js_kbytes) AS max_unused_js_kb
FROM (
  SELECT
    url AS page,
    CAST(JSON_EXTRACT(report, "$.audits.unused-javascript.details.overallSavingsBytes") AS INT64) / 1024 AS unused_js_kbytes
  FROM
    `httparchive.lighthouse.2021_07_01_mobile`)
GROUP BY
  unused_js_kbytes
ORDER BY
  unused_js_kbytes
