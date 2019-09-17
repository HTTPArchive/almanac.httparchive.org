#standardSQL
# 10_12: robots.txt
SELECT
  COUNTIF(robots_txt) AS freq,
  COUNT(0) AS total,
  ROUND(COUNTIF(robots_txt) * 100 / COUNT(0), 2) AS pct
FROM (
  SELECT
    JSON_EXTRACT_SCALAR(report, '$.audits.robots-txt.score') = '1' AS robots_txt
  FROM
    `httparchive.lighthouse.2019_07_01_mobile`)