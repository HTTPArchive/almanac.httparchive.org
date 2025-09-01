#standardSQL
# Purpose
#   Measure the prevalence of Accessibility-related technologies (e.g., overlays)
#   detected by Wappalyzer in the HTTP Archive crawl.
#   The query calculates, by client (desktop/mobile) and root-page flag:
#     • total_sites           = number of unique pages (deduped by page URL)
#     • sites_with_a11y_tech  = number of those pages that use at least one
#                               technology categorized as "Accessibility"
#     • pct_sites_with_a11y_tech = share of pages with Accessibility tech
#
# Sampling
#   • `TABLESAMPLE SYSTEM (0.01 PERCENT)` is included for cheap testing.
#     This dramatically reduces cost by scanning ~0.01% of rows.
#   • IMPORTANT: Results will be noisy and not comparable across runs.
#   • For accurate, publishable numbers, remove the TABLESAMPLE clause.
#
# Notes
#   • The unit here is page (URL), not site/host. COUNT(DISTINCT page) ensures
#     each unique URL is counted once.
#   • `is_root_page` is grouped so you can compare root vs non-root behavior.
#   • If you want “site-level” adoption (combining multiple pages under one host),
#     extract the host from `page` (e.g., REGEXP_EXTRACT) and count distinct hosts instead.
#   • Percentages are computed as ratio of DISTINCT page counts.
#   • Make sure to use the same sampling settings across numerator and denominator.

SELECT
  client,  -- desktop or mobile
  is_root_page,
  COUNT(DISTINCT page) AS total_sites,  -- unique pages for this client/root flag
  COUNT(DISTINCT IF(category = 'Accessibility', page, NULL)) AS sites_with_a11y_tech,
  COUNT(DISTINCT IF(category = 'Accessibility', page, NULL)) / COUNT(DISTINCT page) AS pct_sites_with_a11y_tech
FROM
  `httparchive.crawl.pages`,
  UNNEST(technologies) AS tech,
  UNNEST(categories) AS category
WHERE
  date = '2025-07-01'
GROUP BY
  client,
  is_root_page
ORDER BY
  client,
  is_root_page;
