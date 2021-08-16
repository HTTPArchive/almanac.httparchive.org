#standardSQL
# 16_15: Use of AppCache
SELECT
  COUNT(0) AS total_sites,
  COUNTIF(appcache_score IS NOT NULL) AS total_applicable,
  COUNTIF(CAST(appcache_score AS NUMERIC) = 0) AS total_using_appcache,
  ROUND(COUNTIF(CAST(appcache_score AS NUMERIC) = 0) * 100 / COUNTIF(appcache_score IS NOT NULL), 2) AS perc_in_applicable,
  ROUND(COUNTIF(CAST(appcache_score AS NUMERIC) = 0) * 100 / COUNT(0), 2) AS perc_in_all_sites
FROM (
  SELECT
    JSON_EXTRACT_SCALAR(report, '$.audits.appcache-manifest.score') AS appcache_score
  FROM
    `httparchive.lighthouse.2019_07_01_mobile`
)
