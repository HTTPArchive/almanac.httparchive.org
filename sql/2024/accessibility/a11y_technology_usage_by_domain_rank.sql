#standardSQL
# A11Y technology usage by domain rank
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
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01'  -- Use the relevant date for analysis
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
