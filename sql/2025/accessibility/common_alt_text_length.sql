#standardSQL
-- Most common lengths of <img alt=""> text (2025-07-01)
-- Google Sheets: common_alt_text_length
--
-- Purpose
--   • Expand per-image alt-lengths from custom_metrics and profile distribution.
--   • Report counts and shares across all images and only images with alt (≥ 0),
--     by client and root-page status. Bucket very long values into 2000+.
--
-- Dataset
--   • Source: `httparchive.crawl.pages` (typed JSON)
--   • Field: custom_metrics.other.almanac.images.alt_lengths
--   • Date: 2025-07-01
--
-- Method
--   • UNNEST JSON array via JSON_QUERY_ARRAY(..., '$.images.alt_lengths') → JSON scalars.
--   • Convert to INT with JSON_VALUE → SAFE_CAST.
--   • LEAST(length, 2000) for 2000+ bucket.
--   • Window totals per {client, is_root_page}; compute overall and alt-only percentages.
--
-- Output
--   client, is_root_page, total_images, total_alt_tags,
--   alt_length, occurrences, pct_all_occurrences, pct_of_alt_tags
SELECT
  client,
  is_root_page,
  SUM(COUNT(0)) OVER (PARTITION BY client, is_root_page) AS total_images,
  SUM(COUNTIF(alt_length_clipped >= 0)) OVER (PARTITION BY client, is_root_page) AS total_alt_tags,

  alt_length_clipped AS alt_length,
  COUNT(0) AS occurrences,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client, is_root_page) AS pct_all_occurrences,
  COUNT(0) / NULLIF(SUM(COUNTIF(alt_length_clipped >= 0)) OVER (PARTITION BY client, is_root_page), 0) AS pct_of_alt_tags
FROM (
  SELECT
    client,
    is_root_page,
    LEAST(alt_length, 2000) AS alt_length_clipped
  FROM (
    SELECT
      client,
      is_root_page,
      date,
      SAFE_CAST(JSON_VALUE(alt_json) AS INT64) AS alt_length
    FROM
      `httparchive.crawl.pages`, -- TABLESAMPLE SYSTEM (0.1 PERCENT)
      UNNEST(
        -- was: JSON_EXTRACT_ARRAY(JSON_VALUE(payload, '$._almanac'), '$.images.alt_lengths')
        JSON_QUERY_ARRAY(custom_metrics.other.almanac, '$.images.alt_lengths')
      ) AS alt_json
    WHERE
      date = '2025-07-01'
  )
  WHERE
    alt_length IS NOT NULL AND
    is_root_page IS TRUE
)
GROUP BY
  client, is_root_page, alt_length
ORDER BY
  client, is_root_page, alt_length;
