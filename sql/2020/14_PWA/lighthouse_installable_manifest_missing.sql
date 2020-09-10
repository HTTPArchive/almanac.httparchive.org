#standardSQL
# Check for 'Installable Manifest' missing noted in Lighthouse run - based on 2019/14_02.sql
SELECT
    COUNTIF(manifest) AS freq,
    COUNT(0) AS total,
    ROUND(COUNTIF(manifest) * 100 / COUNT(0), 2) AS pct
FROM (
  SELECT
    JSON_EXTRACT_SCALAR(report, '$.audits.installable-manifest.score') = '1' AS manifest
  FROM
    `httparchive.lighthouse.2020_08_01_mobile`)
