#standardSQL
# Anchors with role='button'
# What this does
# - Reads the 2025-07-01 crawl from `httparchive.crawl.pages`
# - Uses custom_metrics (not the legacy `payload`) to get:
#     - total_anchors_with_role_button: $.a11y.total_anchors_with_role_button
#     - total_anchors: from $.markup.elements.a.count (fallbacks included)
# - Aggregates by client and is_root_page:
#     - sites_with_anchors                    = COUNTIF(total_anchors > 0)
#     - sites_with_anchor_role_button         = COUNTIF(total_anchors_with_role_button > 0)
#     - pct_sites_with_anchor_role_button     = SAFE_DIVIDE(sites_with_anchor_role_button, sites_with_anchors)
# - Sampling: hash-samples by URL to reduce cost. Flip `enable_sample` to FALSE for full run.

WITH cfg AS (
  SELECT
    FALSE  AS enable_sample,   -- set to FALSE for full data
    1000  AS sample_mod,      -- 1 in 1000 (~0.1%)
    0     AS sample_keep      -- keep bucket where MOD(...) = this value
),

page_rows AS (
  SELECT
    p.client,
    p.is_root_page,
    -- a11y metric: anchors having role="button"
    SAFE_CAST(JSON_VALUE(p.custom_metrics.a11y,   '$.total_anchors_with_role_button') AS INT64)
      AS total_anchors_with_role_button,

    -- total anchors; try common paths and fall back to 0
    COALESCE(
      SAFE_CAST(JSON_VALUE(p.custom_metrics.markup, '$.elements.a.count') AS INT64),
      SAFE_CAST(JSON_VALUE(p.custom_metrics.markup, '$.elements.a')       AS INT64),
      0
    ) AS total_anchors
  FROM
    `httparchive.crawl.pages` AS p
  CROSS JOIN cfg
  WHERE
    -- push partition filter INSIDE to avoid scanning all dates
    p.date = '2025-07-01'
    -- low-cost deterministic sampling by URL
    AND (NOT cfg.enable_sample
         OR MOD(ABS(FARM_FINGERPRINT(p.page)), cfg.sample_mod) = cfg.sample_keep)
)

SELECT
  client,
  is_root_page,
  COUNTIF(total_anchors > 0)                         AS sites_with_anchors,
  COUNTIF(total_anchors_with_role_button > 0)        AS sites_with_anchor_role_button,
  SAFE_DIVIDE(
    COUNTIF(total_anchors_with_role_button > 0),
    COUNTIF(total_anchors > 0)
  )                                                  AS pct_sites_with_anchor_role_button
FROM page_rows
GROUP BY client, is_root_page
ORDER BY client, is_root_page;
