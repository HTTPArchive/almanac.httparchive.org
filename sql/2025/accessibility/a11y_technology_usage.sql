#standardSQL
# Purpose
#   Measure the prevalence of Accessibility-related technologies (e.g., overlays)
#   detected by Wappalyzer in the HTTP Archive crawl, by client and root-page flag.
#
# Output columns (page-level, not site-level):
#   • total_sites              = number of unique pages (deduped)
#   • sites_with_a11y_tech     = pages that use ≥1 technology categorized as "Accessibility"
#   • pct_sites_with_a11y_tech = share of pages with Accessibility tech (as "0.0%")
#
# Notes
#   • We first reduce to one row per page with a boolean flag (has_a11y_tech).
#     This avoids any Cartesian effects from UNNESTing arrays.
#   • Percent is computed with SAFE_DIVIDE and also formatted as a string.

WITH page_flags AS (
  SELECT
    p.client,
    p.is_root_page,
    p.page,
    -- true if any category for this page is "Accessibility"
    LOGICAL_OR(category = 'Accessibility') AS has_a11y_tech
  FROM
    `httparchive.crawl.pages` AS p,
    UNNEST(p.technologies) AS tech,
    UNNEST(categories) AS category
  WHERE
    p.date = '2025-07-01'
  GROUP BY
    p.client, p.is_root_page, p.page
)

SELECT
  client,
  is_root_page,
  COUNT(*) AS total_sites,
  COUNTIF(has_a11y_tech) AS sites_with_a11y_tech,
  FORMAT('%.1f%%', 100 * SAFE_DIVIDE(COUNTIF(has_a11y_tech), COUNT(*))) AS pct_sites_with_a11y_tech
FROM page_flags
GROUP BY client, is_root_page
ORDER BY client, is_root_page;
