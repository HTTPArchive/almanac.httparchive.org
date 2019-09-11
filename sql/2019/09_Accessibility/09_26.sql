#standardSQL
# 09_26: Sites that disable zooming and scaling with user-scalable="no"
SELECT
  COUNTIF(REGEXP_EXTRACT(JSON_EXTRACT_SCALAR(payload, '$._meta_viewport'), '(?i)user-scalable\\s*=\\s*no') IS NOT NULL) AS total,
  ROUND(COUNTIF(REGEXP_EXTRACT(JSON_EXTRACT_SCALAR(payload, '$._meta_viewport'), '(?i)user-scalable\\s*=\\s*no') IS NOT NULL) * 100 / COUNTIF(JSON_EXTRACT_SCALAR(payload, '$._meta_viewport') IS NOT NULL), 2) AS percent_of_viewports,
  ROUND(COUNTIF(REGEXP_EXTRACT(JSON_EXTRACT_SCALAR(payload, '$._meta_viewport'), '(?i)user-scalable\\s*=\\s*no') IS NOT NULL) * 100 / COUNT(0), 2) AS percent_of_sites
FROM
  `httparchive.pages.2019_07_01_mobile`
