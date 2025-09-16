#standardSQL
# Purpose
#   Estimate the share of pages using Accessibility-category technologies (e.g., overlays)
#   by client and domain-rank buckets for the 2025-07-01 HTTP Archive crawl.
#   This preserves the original behavior:
#     • Unit: pages (COUNT DISTINCT page), not sites
#     • Grouping: client, is_root_page, rank_grouping (top N thresholds)
#     • Technology filter: category = 'Accessibility'
#
# Sampling (for cheap test runs)
#   To cut cost without biasing the percentage, this script uses a deterministic hash
#   sampler applied IDENTICALLY in both numerator and denominator:
#     MOD(ABS(FARM_FINGERPRINT(page)), cfg.modulus) = cfg.remainder
#   Set cfg.enable_sample = TRUE and pick a modulus to control sample size
#   (e.g., 100_000 ≈ ~0.001 = 0.1%). For full accuracy, set enable_sample = FALSE.
#
#   If you prefer TABLESAMPLE, you must apply it consistently to EVERY reference of
#   `httparchive.crawl.pages` (both subqueries). Otherwise the percentage is biased.
#
# Notes on comparability
#   • Logic and outputs match your original query; only a consistent sampler was added.
#   • Remove or disable sampling for production numbers.

WITH cfg AS (
  SELECT AS STRUCT
    FALSE AS enable_sample, -- set to TRUE for sample
    100000 AS modulus,
    0 AS remainder
)

# Main SELECT statement to aggregate results by client and rank grouping.
SELECT
  client,
  is_root_page,
  rank_grouping,                               # Grouping of domains by rank threshold
  total_in_rank,                               # Total number of pages within the rank grouping
  COUNT(DISTINCT page) AS sites_with_a11y_tech,               # Pages with Accessibility tech
  COUNT(DISTINCT page) / total_in_rank AS pct_sites_with_a11y_tech  # Share within bucket
FROM
  (
    # Subquery: pages with Accessibility technology (numerator)
    SELECT DISTINCT
      p.client,
      p.is_root_page,
      p.page,
      rank_grouping,
      category
    FROM
      `httparchive.crawl.pages` AS p,
      UNNEST([1000, 10000, 100000, 1000000, 10000000, 100000000]) AS rank_grouping,
      UNNEST(p.technologies) AS tech,
      UNNEST(categories) AS category,
      cfg
    WHERE
      p.date = '2025-07-01'
      AND category = 'Accessibility'
      AND p.rank <= rank_grouping
      AND (NOT cfg.enable_sample OR MOD(ABS(FARM_FINGERPRINT(p.page)), cfg.modulus) = cfg.remainder)
      # If you insist on TABLESAMPLE instead of hash sampling, replace the line above with:
      #   -- and also add TABLESAMPLE to the denominator subquery below:
      #   -- FROM `httparchive.crawl.pages` TABLESAMPLE SYSTEM (0.01 PERCENT) AS p, ...
  )
JOIN
  (
    # Subquery: total pages in each rank grouping (denominator)
    SELECT
      p.client,
      rank_grouping,
      COUNT(0) AS total_in_rank
    FROM
      `httparchive.crawl.pages` AS p,
      UNNEST([1000, 10000, 100000, 1000000, 10000000, 100000000]) AS rank_grouping,
      cfg
    WHERE
      p.date = '2025-07-01'
      AND p.rank <= rank_grouping
      AND (NOT cfg.enable_sample OR MOD(ABS(FARM_FINGERPRINT(p.page)), cfg.modulus) = cfg.remainder)
      # If using TABLESAMPLE, apply the SAME TABLESAMPLE here too.
    GROUP BY
      p.client,
      rank_grouping
  )
USING (client, rank_grouping)
GROUP BY
  client,
  is_root_page,
  rank_grouping,
  total_in_rank
ORDER BY
  client,
  is_root_page,
  rank_grouping;
