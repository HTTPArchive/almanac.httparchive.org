-- standardSQL
-- Web Almanac — Most common lengths of <img alt=""> text (sample table; 2025 JSON layout)
--
-- What this query does
--   • Reads per-image ALT-length buckets from the 2025-style JSON:
--       custom_metrics.other.almanac.images.alt_lengths
--     (In this table, 'almanac' is a JSON object; we use JSON_QUERY_ARRAY to fetch the array.)
--   • Expands (UNNESTs) those lengths to image-level rows.
--   • Buckets extreme values into a single “2000+” bucket via LEAST(length, 2000).
--   • Aggregates by {client, is_root_page, alt_length} and reports:
--       - total_images           — partition total images
--       - total_alt_tags         — images where alt_length >= 0 (has alt attribute)
--       - occurrences            — images in this length bucket
--       - pct_all_occurrences    — occurrences / total_images   (human-readable, e.g. "29.6%")
--       - pct_of_alt_tags        — occurrences / total_alt_tags (human-readable)
--
-- Notes
--   • If this sample table doesn’t have a 'date' column, leave the date filter commented out.
--   • If you ever need to support legacy 2024 data (payload._almanac.*), you’d add a COALESCE
--     with JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload,'$._almanac'), '$.images.alt_lengths').
--
WITH per_image AS (
  SELECT
    p.client,
    p.is_root_page,
    -- Elements from JSON_QUERY_ARRAY(...) come out as JSON scalars; JSON_VALUE gets their string value.
    SAFE_CAST(JSON_VALUE(alt_json) AS INT64) AS alt_length
  FROM `httparchive.crawl.pages` AS p
  CROSS JOIN UNNEST(
    JSON_QUERY_ARRAY(p.custom_metrics.other.almanac, '$.images.alt_lengths')
  ) AS alt_json
  WHERE p.custom_metrics.other.almanac IS NOT NULL
    AND p.date = DATE '2025-07-01'
),
bucketed AS (
  SELECT
    client,
    is_root_page,
    LEAST(alt_length, 2000) AS alt_length_clipped
  FROM per_image
  WHERE alt_length IS NOT NULL  -- drop unparsable values
)

SELECT
  client,
  is_root_page,

  -- window totals per {client, is_root_page}
  SUM(COUNT(*)) OVER (PARTITION BY client, is_root_page)                                       AS total_images,
  SUM(COUNTIF(alt_length_clipped >= 0)) OVER (PARTITION BY client, is_root_page)              AS total_alt_tags,

  alt_length_clipped AS alt_length,
  COUNT(*) AS occurrences,

  -- human-readable percentages (0..100%)
  FORMAT('%.1f%%',
         100 * SAFE_DIVIDE(COUNT(*),
                           SUM(COUNT(*)) OVER (PARTITION BY client, is_root_page)))           AS pct_all_occurrences,
  FORMAT('%.1f%%',
         100 * SAFE_DIVIDE(COUNT(*),
                           NULLIF(SUM(COUNTIF(alt_length_clipped >= 0)) OVER (PARTITION BY client, is_root_page), 0)))
                                                                                               AS pct_of_alt_tags
FROM bucketed
GROUP BY client, is_root_page, alt_length
ORDER BY client, is_root_page, alt_length ASC;
