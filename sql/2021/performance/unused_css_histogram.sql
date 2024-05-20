#standardSQL
# Histogram of unused CSS bytes per page

SELECT
  IF(unused_css_kbytes <= 500, CEIL(unused_css_kbytes / 10) * 10, 500) AS unused_css_kbytes,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY 0) AS pct,
  COUNT(0) AS pages,
  SUM(COUNT(0)) OVER (PARTITION BY 0) AS total,
  --only interested in last max one as a 'surprising metric'
  MAX(unused_css_kbytes) AS max_unused_css_kb
FROM (
  SELECT
    url AS page,
    CAST(JSON_EXTRACT(report, '$.audits.unused-css-rules.details.overallSavingsBytes') AS INT64) / 1024 AS unused_css_kbytes
  FROM
    `httparchive.lighthouse.2021_07_01_mobile`
)
GROUP BY
  unused_css_kbytes
ORDER BY
  unused_css_kbytes
