#standardSQL
# Analyze the usage of viewport tags and scaling behavior by domain rank

WITH RankedPages AS (
  SELECT
    client,
    is_root_page,
    JSON_EXTRACT_SCALAR(payload, '$._meta_viewport') AS meta_viewport,
    rank
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'
),

RankGroups AS (
  SELECT
    client,
    is_root_page,
    rank,
    CASE
      WHEN rank <= 1000 THEN 1000
      WHEN rank <= 10000 THEN 10000
      WHEN rank <= 100000 THEN 100000
      WHEN rank <= 1000000 THEN 1000000
      WHEN rank <= 10000000 THEN 10000000
      ELSE 100000000
    END AS rank_grouping
  FROM
    RankedPages
),

AggregatedData AS (
  SELECT
    client,
    is_root_page,
    rank_grouping,
    COUNT(0) AS total_pages,
    COUNTIF(meta_viewport IS NOT NULL) AS total_viewports,
    COUNTIF(REGEXP_EXTRACT(meta_viewport, r'(?i)user-scalable\s*=\s*(no|0)') IS NOT NULL) AS total_no_scale,
    COUNTIF(SAFE_CAST(REGEXP_EXTRACT(meta_viewport, r'(?i)maximum-scale\s*=\s*([0-9]*\.[0-9]+|[0-9]+)') AS FLOAT64) <= 1) AS total_locked_max_scale,
    COUNTIF(
      REGEXP_EXTRACT(meta_viewport, r'(?i)user-scalable\s*=\s*(no|0)') IS NOT NULL OR
      SAFE_CAST(REGEXP_EXTRACT(meta_viewport, r'(?i)maximum-scale\s*=\s*([0-9]*\.[0-9]+|[0-9]+)') AS FLOAT64) <= 1
    ) AS total_either
  FROM
    RankGroups
  LEFT JOIN
    RankedPages
  USING (client, is_root_page, rank)
  GROUP BY
    client,
    is_root_page,
    rank_grouping
)

SELECT
  client,
  is_root_page,
  rank_grouping,
  total_pages,
  total_viewports,
  total_no_scale,
  total_locked_max_scale,
  total_either,
  SAFE_DIVIDE(total_no_scale, total_pages) AS pct_pages_no_scale,
  SAFE_DIVIDE(total_locked_max_scale, total_pages) AS pct_pages_locked_max_scale,
  SAFE_DIVIDE(total_either, total_pages) AS pct_pages_either
FROM
  AggregatedData
ORDER BY
  client,
  is_root_page,
  rank_grouping;
