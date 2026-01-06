#standardSQL
# Disabled zooming and scaling via the viewport tag

-- custom_metrics.other.meta_viewport is blank so use the almanac one instead
CREATE TEMPORARY FUNCTION getMetaViewport(meta_nodes JSON)
RETURNS STRING
LANGUAGE js
AS '''
if (!Array.isArray(meta_nodes)) return;
return meta_nodes?.find(node => node.name === 'viewport')?.content
''';

SELECT
  client,
  is_root_page,
  COUNT(0) AS total_pages,
  COUNTIF(has_meta_viewport) AS total_viewports,
  COUNTIF(not_scalable) AS total_no_scale,
  COUNTIF(max_scale_1_or_less) AS total_locked_max_scale,
  COUNTIF(not_scalable OR max_scale_1_or_less) AS total_either,

  COUNTIF(not_scalable) / COUNT(0) AS pct_pages_no_scale,
  COUNTIF(max_scale_1_or_less) / COUNT(0) AS pct_pages_locked_max_scale,
  COUNTIF(not_scalable OR max_scale_1_or_less) / COUNT(0) AS pct_pages_either
FROM (
  SELECT
    client,
    is_root_page,
    meta_viewport IS NOT NULL AS has_meta_viewport,
    REGEXP_EXTRACT(meta_viewport, r'(?i)user-scalable\s*=\s*(no|0)') IS NOT NULL AS not_scalable,
    SAFE_CAST(REGEXP_EXTRACT(meta_viewport, r'(?i)maximum-scale\s*=\s*([0-9]*\.[0-9]+|[0-9]+)') AS FLOAT64) <= 1 AS max_scale_1_or_less
  FROM (
    SELECT
      client,
      is_root_page,
      getMetaViewport(custom_metrics.other.almanac.`meta-nodes`.nodes) AS meta_viewport
    FROM
      `httparchive.crawl.pages`
    WHERE
      date = '2025-07-01'
  )
)
GROUP BY
  client,
  is_root_page;
