#standardSQL
# 12_04: Sites that disable zooming and scaling via the viewport tag
SELECT
  client,
  COUNT(0) AS total_sites,
  COUNTIF(has_meta_viewport) AS total_viewports,
  COUNTIF(not_scalable) AS total_no_scale,
  COUNTIF(locked_max_scale) AS total_locked_max_scale,
  COUNTIF(not_scalable OR locked_max_scale) AS total_either,

  ROUND(COUNTIF(not_scalable) * 100 / COUNT(0), 2) AS perc_sites_no_scale,
  ROUND(COUNTIF(locked_max_scale) * 100 / COUNT(0), 2) AS perc_sites_locked_max_scale,
  ROUND(COUNTIF(not_scalable OR locked_max_scale) * 100 / COUNT(0), 2) AS perc_sites_either
FROM (
  SELECT
    client,
    meta_viewport IS NOT NULL AS has_meta_viewport,
    REGEXP_EXTRACT(meta_viewport, '(?i)user-scalable\\s*=\\s*(no|0)') IS NOT NULL AS not_scalable,
    REGEXP_EXTRACT(meta_viewport, '(?i)maximum-scale\\s*=\\s*1') IS NOT NULL AS locked_max_scale
  FROM (
    SELECT
      _TABLE_SUFFIX AS client,
      JSON_EXTRACT_SCALAR(payload, '$._meta_viewport') AS meta_viewport
    FROM
      `httparchive.pages.2019_07_01_*`
  )
)
GROUP BY client
