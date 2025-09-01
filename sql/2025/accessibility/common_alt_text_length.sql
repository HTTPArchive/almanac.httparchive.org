-- standardSQL
-- Web Almanac — Most common lengths of <img alt=""> text (page sample)
--
-- What this measures
--   • For each {client, is_root_page}, we bucket the length of each image's ALT text.
--   • ALT length semantics:
--       -1  = no alt attribute
--        0  = empty alt=""
--       >=1 = character count of the alt text
--   • Extremely long alts are grouped into a 2000+ bucket.
--
-- Output columns
--   client, is_root_page
--   total_images                — total images seen in the partition (sampled)
--   total_alt_tags              — images where alt_length >= 0 (has alt attribute)
--   alt_length                  — reported bucket (LEAST(length, 2000))
--   occurrences                 — number of images with this bucket
--   pct_all_occurrences_num     — occurrences / total_images (0..1)
--   pct_all_occurrences         — formatted percentage (e.g. "57.2%")
--   pct_of_alt_tags_num         — occurrences / total_alt_tags (0..1)
--   pct_of_alt_tags             — formatted percentage (e.g. "24.4%")
--
-- Notes
--   • Data source for ALT lengths is the legacy Almanac path:
--       payload._almanac.images.alt_lengths (array of strings)
--     If/when a 2025+ path appears in custom_metrics, this can be extended.
--   • This is image-level (not site-level). We keep root/non-root split.
--   • Use TABLESAMPLE SYSTEM for fast test runs; adjust/remove for full runs.
--
WITH per_image AS (
  SELECT
    client,
    is_root_page,
    -- Parse each element of the alt_lengths array; keep NULLs out later
    SAFE_CAST(alt_length_str AS INT64) AS alt_length
  FROM
    `httparchive.crawl.pages`
    , UNNEST(
        JSON_EXTRACT_ARRAY(
          JSON_EXTRACT_SCALAR(payload, '$._almanac'),
          '$.images.alt_lengths'
        )
      ) AS alt_length_str
  WHERE
    date = '2025-07-01'
    AND is_root_page IS TRUE                 -- keep the root/non-root structure like 2024
    AND alt_length_str IS NOT NULL
),
bucketed AS (
  SELECT
    client,
    is_root_page,
    LEAST(alt_length, 2000) AS alt_length_clipped
  FROM per_image
  WHERE alt_length IS NOT NULL               -- discard any unparsable values
)
SELECT
  client,
  is_root_page,

  -- window totals per {client, is_root_page}
  SUM(COUNT(*)) OVER (PARTITION BY client, is_root_page)                                     AS total_images,
  SUM(COUNTIF(alt_length_clipped >= 0)) OVER (PARTITION BY client, is_root_page)            AS total_alt_tags,

  alt_length_clipped AS alt_length,
  COUNT(*) AS occurrences,

  -- numeric ratios (0..1)
  SAFE_DIVIDE(COUNT(*),
              SUM(COUNT(*)) OVER (PARTITION BY client, is_root_page))                        AS pct_all_occurrences_num,
  SAFE_DIVIDE(COUNT(*),
              NULLIF(SUM(COUNTIF(alt_length_clipped >= 0)) OVER (PARTITION BY client, is_root_page), 0))
                                                                                            AS pct_of_alt_tags_num,

  -- human-readable percentages
  FORMAT('%.1f%%',
         100 * SAFE_DIVIDE(COUNT(*),
                           SUM(COUNT(*)) OVER (PARTITION BY client, is_root_page)))         AS pct_all_occurrences,
  FORMAT('%.1f%%',
         100 * SAFE_DIVIDE(COUNT(*),
                           NULLIF(SUM(COUNTIF(alt_length_clipped >= 0)) OVER (PARTITION BY client, is_root_page), 0)))
                                                                                            AS pct_of_alt_tags
FROM bucketed
GROUP BY
  client,
  is_root_page,
  alt_length
ORDER BY
  client, is_root_page, alt_length ASC;
