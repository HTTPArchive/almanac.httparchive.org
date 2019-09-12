#standardSQL
# 09_26: Sites that disable zooming and scaling with user-scalable="no"
SELECT
  client,
  COUNT(0) AS total_sites,
  COUNTIF(meta_viewport IS NOT NULL) AS total_viewports,
  COUNTIF(REGEXP_EXTRACT(meta_viewport, '(?i)user-scalable\\s*=\\s*no') IS NOT NULL) AS total_no_scale,
  ROUND(COUNTIF(REGEXP_EXTRACT(meta_viewport, '(?i)user-scalable\\s*=\\s*no') IS NOT NULL) * 100 / COUNTIF(meta_viewport IS NOT NULL), 2) AS percent_of_viewports,
  ROUND(COUNTIF(REGEXP_EXTRACT(meta_viewport, '(?i)user-scalable\\s*=\\s*no') IS NOT NULL) * 100 / COUNT(0), 2) AS percent_of_sites
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    JSON_EXTRACT_SCALAR(payload, '$._meta_viewport') AS meta_viewport
  FROM
    `httparchive.pages.2019_07_01_*`
)
GROUP BY client
