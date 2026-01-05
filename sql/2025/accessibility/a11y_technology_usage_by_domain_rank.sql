#standardSQL
# Purpose
#   Measure adoption of specific Accessibility-related technologies (apps/overlays)
#   across domain rank buckets in the 2025-07-01 HTTP Archive crawl.
#   Google Sheet: a11y_technology_usage_by_domain_rank
#
# Output columns
#   • client             = desktop or mobile
#   • is_root_page       = TRUE if page is the root of the site
#   • rank_grouping      = domain rank bucket (1k, 10k, …, 100M)
#   • total_in_rank      = total number of unique pages in the rank bucket
#   • app                = specific Accessibility technology detected (Wappalyzer name)
#   • sites_with_app     = number of unique pages using that technology
#   • pct_sites_with_app = share of pages in the rank bucket using that technology
#
# Method
#   1. Assign each page to a rank_grouping based on its domain rank.
#   2. Compute totals per client / root flag / rank grouping (denominator).
#   3. Expand technologies and categories, keeping only category = 'Accessibility'.
#   4. Count distinct pages per technology and divide by the rank total.
#
# Notes
#   • Unit of analysis = page URL, not host/site.
#   • Percentages are returned as numeric fractions (0–1). Use FORMAT() if a
#     human-readable percent string is needed.
#   • Rank groupings are aligned with prior reporting thresholds (1k → 100M).
WITH ranked_sites AS (
  -- Get the total number of sites within each rank grouping
  SELECT
    client,
    is_root_page,
    page,
    rank,
    technologies,  -- Include technologies field here
    CASE
      WHEN rank <= 1000 THEN 1000
      WHEN rank <= 10000 THEN 10000
      WHEN rank <= 100000 THEN 100000
      WHEN rank <= 1000000 THEN 1000000
      WHEN rank <= 10000000 THEN 10000000
      WHEN rank <= 100000000 THEN 100000000
    END AS rank_grouping
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'  -- Use the relevant date for analysis
),

rank_totals AS (
  -- Calculate total sites in each rank grouping
  SELECT
    client,
    is_root_page,
    rank_grouping,
    COUNT(DISTINCT page) AS total_in_rank
  FROM
    ranked_sites
  GROUP BY
    client,
    is_root_page,
    rank_grouping
)

SELECT
  r.client,
  r.is_root_page,
  r.rank_grouping,
  rt.total_in_rank,  -- Total number of unique sites within the rank grouping
  tech.technology AS app,  -- Accessibility technology used
  COUNT(DISTINCT r.page) AS sites_with_app,  -- Number of sites using the specific accessibility technology
  SAFE_DIVIDE(COUNT(DISTINCT r.page), rt.total_in_rank) AS pct_sites_with_app  -- Percentage of sites using the accessibility technology
FROM
  ranked_sites r
JOIN
  UNNEST(r.technologies) AS tech  -- Expand technologies array to individual rows
JOIN
  rank_totals rt  -- Join to get the total number of sites per rank grouping
ON r.client = rt.client AND
  r.is_root_page = rt.is_root_page AND
  r.rank_grouping = rt.rank_grouping
JOIN
  UNNEST(tech.categories) AS category  -- Unnest the categories array to filter for accessibility
WHERE
  category = 'Accessibility'  -- Filter to include only accessibility-related technologies
GROUP BY
  r.client,
  r.is_root_page,
  r.rank_grouping,
  rt.total_in_rank,
  tech.technology
ORDER BY
  tech.technology,  -- Order results by technology (app)
  r.rank_grouping,  -- Order results by rank grouping
  r.client,
  r.is_root_page;
