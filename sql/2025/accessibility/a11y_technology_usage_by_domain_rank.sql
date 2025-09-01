#standardSQL
# Purpose
#   Report prevalence of ALL Accessibility-category technologies by domain-rank bucket,
#   split by client and root-page flag, for a single crawl date.
#   For each (client, is_root_page, rank_grouping, app) compute:
#     • total_in_rank        = distinct pages in the bucket (denominator)
#     • sites_with_app       = distinct pages using that technology
#     • pct_sites_with_app   = 100 * sites_with_app / total_in_rank (percent points)
#
# Design
#   • Shared base CTE (ranked_pages) feeds both numerator and denominator.
#   • LEFT JOIN keeps buckets even when a vendor has zero hits.
#   • Toggleable deterministic sampler for cheap tests; disable for production.
#   • Unit is page (distinct URL). For site-level, replace DISTINCT page with
#     DISTINCT REGEXP_EXTRACT(page, r'^https?://([^/]+)') in BOTH numerator and denominator.
#
# How to use
#   • Set cfg.enable_sample = FALSE for YoY comparability (full partition).
#   • Keep the date, bucket CASE thresholds, and filters identical across years.

WITH cfg AS (
  SELECT
    FALSE AS enable_sample,   -- set TRUE for cheap tests; FALSE for full run
    10000 AS modulus,         -- if sampling: ~0.01% when TRUE
    0     AS remainder
),

ranked_pages AS (
  SELECT
    p.client,
    p.is_root_page,
    p.page,
    CASE
      WHEN p.rank <= 1000 THEN 1000
      WHEN p.rank <= 10000 THEN 10000
      WHEN p.rank <= 100000 THEN 100000
      WHEN p.rank <= 1000000 THEN 1000000
      WHEN p.rank <= 10000000 THEN 10000000
      WHEN p.rank <= 100000000 THEN 100000000
      ELSE NULL
    END AS rank_grouping,
    p.technologies
  FROM `httparchive.crawl.pages` AS p, cfg
  WHERE
    p.date = '2025-07-01'
    AND p.rank IS NOT NULL
    AND p.rank <= 100000000
    AND (
      NOT cfg.enable_sample
      OR MOD(ABS(FARM_FINGERPRINT(p.page)), cfg.modulus) = cfg.remainder
    )
),

rank_totals AS (
  SELECT
    client,
    is_root_page,
    rank_grouping,
    COUNT(DISTINCT page) AS total_in_rank
  FROM ranked_pages
  WHERE rank_grouping IS NOT NULL
  GROUP BY client, is_root_page, rank_grouping
),

vendor_hits AS (
  -- Count pages per Accessibility vendor
  SELECT
    rp.client,
    rp.is_root_page,
    rp.rank_grouping,
    tech.technology AS app,
    COUNT(DISTINCT rp.page) AS pages_with_vendor
  FROM ranked_pages rp
  CROSS JOIN UNNEST(rp.technologies) AS tech
  WHERE
    rp.rank_grouping IS NOT NULL
    AND EXISTS (
      SELECT 1
      FROM UNNEST(tech.categories) AS c
      WHERE c = 'Accessibility'
    )
  GROUP BY rp.client, rp.is_root_page, rp.rank_grouping, app
)

SELECT
  rt.client,
  rt.is_root_page,
  rt.rank_grouping,
  rt.total_in_rank,
  vh.app,
  IFNULL(vh.pages_with_vendor, 0) AS sites_with_app,
  ROUND(100 * SAFE_DIVIDE(IFNULL(vh.pages_with_vendor, 0), rt.total_in_rank), 1) AS pct_sites_with_app
FROM rank_totals rt
LEFT JOIN vendor_hits vh
  ON vh.client = rt.client
 AND vh.is_root_page = rt.is_root_page
 AND vh.rank_grouping = rt.rank_grouping
ORDER BY
  vh.app, rt.rank_grouping, rt.client, rt.is_root_page;
