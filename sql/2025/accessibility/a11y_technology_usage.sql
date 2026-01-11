#standardSQL
-- Accessibility Technology (A11y) Usage by Client (2025-07-01)
-- Google Sheets: a11y_technology_usage
--
-- Purpose
--   • Measure the adoption of accessibility-related technologies (e.g., overlays)
--     across websites, segmented by client type (desktop vs mobile).
--   • Provide absolute counts of sites with A11y tech and their percentage share
--     relative to all sites.
--
-- Dataset
--   • Source: `httparchive.crawl.pages`
--   • Crawl date: 2025-07-01
--   • Technologies: extracted via `UNNEST(technologies)` and `UNNEST(categories)`.
--
-- Method
--   1. Count distinct sites (pages) per {client, is_root_page}.
--   2. Count distinct sites where `category = 'Accessibility'`.
--   3. Compute percentage as (# sites with A11y tech / total sites).
--
-- Output columns
--   client                  — "desktop" | "mobile"
--   is_root_page            — TRUE if page is a root URL
--   total_sites             — number of distinct sites per client
--   sites_with_a11y_tech    — number of distinct sites with Accessibility technology
--   pct_sites_with_a11y_tech — fraction of sites using A11y tech (0–1 float)
--
-- Notes
--   • `DISTINCT page` prevents double-counting when a site has multiple technologies.
--   • Percentages are per client (desktop/mobile) and root-page grouping.
--   • Useful for high-level comparison of A11y tech adoption across clients.
SELECT
  client,  # Client domain
  is_root_page,
  COUNT(DISTINCT page) AS total_sites,  # Total number of unique sites for the client
  COUNT(DISTINCT IF(category = 'Accessibility', page, NULL)) AS sites_with_a11y_tech,  # Number of unique sites that use accessibility technology
  COUNT(DISTINCT IF(category = 'Accessibility', page, NULL)) / COUNT(DISTINCT page) AS pct_sites_with_a11y_tech  # Percentage of sites using accessibility technology
FROM
  `httparchive.crawl.pages`,
  UNNEST(technologies) AS tech,
  UNNEST(categories) AS category
WHERE
  date = '2025-07-01' # Specific date for data extraction
GROUP BY
  client,
  is_root_page
ORDER BY
  client,
  is_root_page;
