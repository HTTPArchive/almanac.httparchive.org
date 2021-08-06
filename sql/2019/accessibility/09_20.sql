#standardSQL
# 09_20: % of mobile pages with valid aria attribute values, scored by Lighthouse
SELECT
  is_valid,
  COUNT(0) AS pages,
  SUM(COUNT(0)) OVER (PARTITION BY 0) AS total,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY 0), 2) AS pct
FROM (
  SELECT
    JSON_EXTRACT_SCALAR(report, "$.audits['aria-valid-attr-value'].score") = '1' AS is_valid
  FROM
    `httparchive.lighthouse.2019_07_01_mobile`)
WHERE
  # Ignore pages with no aria-* attributes
  is_valid IS NOT NULL
GROUP BY
  is_valid
ORDER BY
  pages DESC
