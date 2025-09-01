#standardSQL
# Purpose
#   Report usage of Accessibility-category technologies by domain-rank buckets,
#   split by client and root-page flag. For each rank bucket, compute:
#     • total_in_rank        = distinct pages in the bucket
#     • sites_with_app       = distinct pages using each Accessibility technology
#     • pct_sites_with_app   = sites_with_app / total_in_rank
#
# How to use the toggle the deterministic hash sampler
#   • For cheap test runs:    set cfg.enable_sample = TRUE and pick a modulus (e.g. 10000 ≈ ~0.01%).
#   • For full production:    set cfg.enable_sample = FALSE (sampler bypassed).

WITH cfg AS (
  SELECT
    FALSE  AS enable_sample,   -- set TRUE for full table (no sampling)
    10000 AS modulus,         -- larger = smaller sample (e.g., 10000 ≈ 0.01%)
    0     AS remainder        -- choose any remainder in [0, modulus-1] for a different slice
),

ranked_sites AS (
  -- Base set of pages with rank bucket
  SELECT
    p.client,
    p.is_root_page,
    p.page,
    p.rank,
    p.technologies,
    CASE
      WHEN p.rank <= 1000 THEN 1000
      WHEN p.rank <= 10000 THEN 10000
      WHEN p.rank <= 100000 THEN 100000
      WHEN p.rank <= 1000000 THEN 1000000
      WHEN p.rank <= 10000000 THEN 10000000
      WHEN p.rank <= 100000000 THEN 100000000
      ELSE NULL
    END AS rank_grouping
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
  -- Denominator: total distinct pages per client/root/rank bucket
  SELECT
    client,
    is_root_page,
    rank_grouping,
    COUNT(DISTINCT page) AS total_in_rank
  FROM ranked_sites
  WHERE rank_grouping IS NOT NULL
  GROUP BY client, is_root_page, rank_grouping
)

SELECT
  r.client,
  r.is_root_page,
  r.rank_grouping,
  rt.total_in_rank,                                        -- denominator
  tech.technology AS app,                                  -- each Accessibility technology
  COUNT(DISTINCT r.page) AS sites_with_app,                -- pages using that app
  SAFE_DIVIDE(COUNT(DISTINCT r.page), rt.total_in_rank) AS pct_sites_with_app
FROM ranked_sites AS r
CROSS JOIN UNNEST(r.technologies) AS tech
JOIN rank_totals AS rt
  ON rt.client = r.client
 AND rt.is_root_page = r.is_root_page
 AND rt.rank_grouping = r.rank_grouping
WHERE
  r.rank_grouping IS NOT NULL
  AND EXISTS (
    SELECT 1
    FROM UNNEST(tech.categories) AS c
    WHERE c = 'Accessibility'
  )
GROUP BY
  r.client, r.is_root_page, r.rank_grouping, rt.total_in_rank, tech.technology
ORDER BY
  tech.technology, r.rank_grouping, r.client, r.is_root_page;
