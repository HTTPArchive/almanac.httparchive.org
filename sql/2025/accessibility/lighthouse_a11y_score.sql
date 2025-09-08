#standardSQL
-- Web Almanac — Percentiles of Lighthouse accessibility scores (exact sorting)
--
-- What this does
--   • Extracts `categories.accessibility.score` (0..1) from Lighthouse JSON.
--   • Filters to pages with valid, non-null scores on crawl date 2025-07-01.
--   • Sorts scores per {client, is_root_page} and assigns row numbers + total counts.
--   • Computes percentile positions (0..1) via (rank-1)/total_count.
--   • Joins against target percentiles [10%, 25%, 50%, 75%, 90%] and keeps rows near each.
--   • Averages ties when multiple rows are equally close to a percentile.
--   • Outputs exact scores per percentile, per client/device + root-page flag.
--
-- Notes
--   • SAMPLE vs LIVE: uncomment `TABLESAMPLE SYSTEM (0.1 PERCENT)` in `score_data` for cheap smoke tests,
--     or remove/comment it for the full crawl.
--   • Exact percentiles here are “nearest value” estimates, not interpolated midpoints.
--   • Output includes both raw score (0..1) and average at each percentile.
--
-- Output columns
--   client        — "mobile" or "desktop"
--   is_root_page  — boolean (true if root page)
--   date          — crawl date (string "2025-07-01")
--   percentile    — requested percentile (float, e.g. 0.25 for 25th)
--   exact_score   — average score of rows closest to the percentile

WITH score_data AS (
  SELECT
    client,
    is_root_page,
    CAST(JSON_VALUE(lighthouse, '$.categories.accessibility.score') AS FLOAT64) AS score
  FROM
    `httparchive.crawl.pages`
    -- TABLESAMPLE SYSTEM (0.1 PERCENT)  -- uncomment for SMOKE TESTING
  WHERE
    date = DATE '2025-07-01'
    -- AND is_root_page
    AND lighthouse IS NOT NULL
    AND JSON_TYPE(lighthouse) = 'object'                                   -- valid JSON object
    AND JSON_VALUE(lighthouse, '$.categories.accessibility.score') IS NOT NULL  -- has a score
),

sorted_scores AS (
  SELECT
    client,
    is_root_page,
    score,
    ROW_NUMBER() OVER (PARTITION BY client, is_root_page ORDER BY score ASC) AS rank,
    COUNT(0) OVER (PARTITION BY client, is_root_page) AS total_count
  FROM
    score_data
),

percentiles AS (
  SELECT
    client,
    is_root_page,
    rank,
    total_count,
    (rank - 1) / total_count AS percentile_value,
    score
  FROM
    sorted_scores
)

SELECT
  client,
  is_root_page,
  '2025-07-01' AS date,
  percentile,
  FORMAT('%.1f%%', 100 * AVG(score)) AS exact_score_pct
FROM
  percentiles,
  UNNEST([0.1, 0.25, 0.5, 0.75, 0.9]) AS percentile  -- Target percentiles (e.g., 10th, 25th, 50th, etc.)
WHERE
  ABS(percentile_value - percentile) < 0.01  -- Match scores around the percentile value
GROUP BY client, is_root_page, percentile
ORDER BY client, is_root_page, percentile;
