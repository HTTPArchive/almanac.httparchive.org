#standardSQL
-- Accessibility Technology (A11y) Usage by Domain Rank (2025-07-01)
-- Google Sheet: a11y_overall_tech_usage_by_domain_rank
--
-- Purpose
--   • Quantify adoption of accessibility-related technologies (e.g., overlays)
--     across websites, segmented by domain rank tiers.
--   • Provide both absolute counts of sites using A11y tech and percentages
--     within each rank grouping.
--
-- Dataset
--   • Source: `httparchive.crawl.pages`
--   • Crawl date: 2025-07-01
--   • Technologies: extracted from `technologies` and `categories` arrays.
--   • Rank groupings: [1K, 10K, 100K, 1M, 10M, 100M].
--
-- Method
--   1. Subquery A:
--        – Expand rank thresholds with UNNEST.
--        – Select distinct {client, page, is_root_page, rank_grouping}
--          where `category = 'Accessibility'`.
--   2. Subquery B:
--        – Count all sites per {client, rank_grouping} as denominators
--          (total sites in each rank band).
--   3. Join Subquery A with Subquery B on {client, rank_grouping}.
--   4. Aggregate results to compute distinct site counts and percentages.
--
-- Output columns
--   client                  — "desktop" | "mobile"
--   is_root_page            — TRUE if page is a root URL
--   rank_grouping           — maximum rank threshold (e.g., 1000, 10000, …)
--   total_in_rank           — total number of sites within the rank group
--   sites_with_a11y_tech    — count of distinct sites using A11y technology
--   pct_sites_with_a11y_tech — fraction of sites in rank group using A11y tech
--
-- Notes
--   • Percentages are relative to the total sites in each rank grouping.
--   • Multiple rank thresholds allow trend analysis across different scales
--     of the web (top 1K → top 100M).
--   • `is_root_page` is preserved to allow filtering on root vs non-root pages.
SELECT
  client,
  is_root_page,
  rank_grouping, # Grouping of domains by their rank (e.g., top 1000, top 10000, etc.)
  total_in_rank, # Total number of sites within the rank grouping
  COUNT(DISTINCT page) AS sites_with_a11y_tech, # Number of unique sites that use accessibility technology
  COUNT(DISTINCT page) / total_in_rank AS pct_sites_with_a11y_tech # Percentage of sites using accessibility technology within the rank grouping
FROM
  (
    # Subquery to filter and extract relevant pages with A11Y technology
    SELECT DISTINCT
      client,
      is_root_page,
      page,
      rank_grouping,
      category
    FROM
      `httparchive.crawl.pages`,
      UNNEST([1000, 10000, 100000, 1000000, 10000000, 100000000]) AS rank_grouping, # Expand rank_grouping to cover different rank categories
      UNNEST(technologies) AS tech,
      UNNEST(categories) AS category
    WHERE
      date = '2025-07-01' AND
      category = 'Accessibility' AND
      rank <= rank_grouping # Include only sites within the specified rank grouping
  )
JOIN
  (
    # Subquery to count total sites in each rank grouping for each client
    SELECT
      client,
      rank_grouping,
      COUNT(0) AS total_in_rank
    FROM
      `httparchive.crawl.pages`,
      UNNEST([1000, 10000, 100000, 1000000, 10000000, 100000000]) AS rank_grouping
    WHERE
      date = '2025-07-01' AND
      rank <= rank_grouping
    GROUP BY
      client,
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
  rank_grouping
