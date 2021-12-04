#standardSQL
# Disabled zooming and scaling via the viewport tag by domain rank
SELECT
  client,
  rank_grouping,

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
    url,
    meta_viewport IS NOT NULL AS has_meta_viewport,
    REGEXP_EXTRACT(meta_viewport, r'(?i)user-scalable\s*=\s*(no|0)') IS NOT NULL AS not_scalable,
    SAFE_CAST(REGEXP_EXTRACT(meta_viewport, r'(?i)maximum-scale\s*=\s*([0-9]*\.[0-9]+|[0-9]+)') AS FLOAT64) <= 1 AS max_scale_1_or_less
  FROM (
    SELECT
      _TABLE_SUFFIX AS client,
      url,
      JSON_EXTRACT_SCALAR(payload, '$._meta_viewport') AS meta_viewport
    FROM
      `httparchive.pages.2021_07_01_*`
  )
)
LEFT JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    rank_grouping
  FROM
    `httparchive.summary_pages.2021_07_01_*`,
    UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS rank_grouping
  WHERE
    rank <= rank_grouping
) USING (client, url)
GROUP BY
  rank_grouping,
  client
