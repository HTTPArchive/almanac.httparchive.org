#standardSQL
# 11_02: Check for 'Installable Manifest' missing noted in Lighthouse run
SELECT
  COUNTIF(manifest) AS freq,
  COUNT(0) AS total,
  ROUND(COUNTIF(manifest) * 100 / COUNT(0), 2) AS pct
FROM (
  SELECT
    JSON_EXTRACT_SCALAR(report, '$.audits.installable-manifest.score') = '1' AS manifest
  FROM
    `httparchive.lighthouse.2019_07_01_mobile`)
