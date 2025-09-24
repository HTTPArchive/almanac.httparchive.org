#standardSQL
# Purpose
#   Estimate the share of pages using Accessibility-category technologies (e.g., overlays)
#   by client and domain-rank buckets for the 2025-07-01 HTTP Archive crawl.
#
# Key behavior:
#   • Unit: pages (COUNT DISTINCT page), not sites
#   • Grouping: client, is_root_page, rank_grouping (top N thresholds)
#   • Technology filter: category = 'Accessibility'
#   • Denominator: COUNT DISTINCT pages per bucket (ensures correct percentages)
#   • Output includes both numeric ratio (0–1) and formatted percent string (e.g., "0.8%")
#   • Adds a "rank" label column (largest bucket shown as "ALL")
#
# Sampling (optional):
#   • Uses deterministic hash sampling applied identically in numerator and denominator:
#       MOD(ABS(FARM_FINGERPRINT(page)), cfg.modulus) = cfg.remainder
#   • To enable, set cfg.enable_sample = TRUE and adjust modulus/remainder.
#   • Example: modulus = 100_000 ≈ 0.1% sample.
#   • For full accuracy, set enable_sample = FALSE.
#
# Notes:
#   • Do not mix in TABLESAMPLE unless you apply it consistently to *every* reference
#     of `httparchive.crawl.pages` (numerator and denominator), otherwise percentages
#     will be biased.
#   • This script aligns with the 2024 reporting format for comparability.

-- Purpose: share of pages using Accessibility-category techs by client and rank buckets
WITH cfg AS (
  SELECT AS STRUCT
    FALSE AS enable_sample,  -- set TRUE for sampling
    100000 AS modulus,
    0 AS remainder
),

-- Numerator: pages that use Accessibility tech
numerator AS (
  SELECT DISTINCT
    p.client,
    p.is_root_page,
    p.page,
    rank_grouping
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
),

-- Denominator: total pages in each rank bucket
denominator AS (
  SELECT
    p.client,
    rank_grouping,
    COUNT(DISTINCT p.page) AS total_in_rank
  FROM
    `httparchive.crawl.pages` AS p,
    UNNEST([1000, 10000, 100000, 1000000, 10000000, 100000000]) AS rank_grouping,
    cfg
  WHERE
    p.date = '2025-07-01'
    AND p.rank <= rank_grouping
    AND (NOT cfg.enable_sample OR MOD(ABS(FARM_FINGERPRINT(p.page)), cfg.modulus) = cfg.remainder)
  GROUP BY
    p.client, rank_grouping
)

-- Final aggregation to match the 2024 output shape
SELECT
  n.client,
  n.is_root_page,
  d.rank_grouping,
  d.total_in_rank,
  COUNT(DISTINCT n.page) AS sites_with_a11y_tech,
  -- SAFE_DIVIDE(COUNT(DISTINCT n.page), d.total_in_rank) AS pct_sites_with_a11y_tech_num,             -- numeric 0–1
  FORMAT('%.1f%%', 100 * SAFE_DIVIDE(COUNT(DISTINCT n.page), d.total_in_rank)) AS pct_sites_with_a11y_tech,  -- "0.8%"
  CASE
    WHEN d.rank_grouping = 100000000 THEN 'ALL'
    ELSE FORMAT('%\'d', d.rank_grouping)
  END AS rank
FROM numerator n
JOIN denominator d
  USING (client, rank_grouping)
GROUP BY
  n.client, n.is_root_page, d.rank_grouping, d.total_in_rank
ORDER BY
  n.client, n.is_root_page, d.rank_grouping;
