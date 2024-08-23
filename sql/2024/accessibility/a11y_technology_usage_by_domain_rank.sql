#standardSQL
# A11Y technology usage by domain rank
SELECT
  client,  # Client domain
  rank_grouping,  # Grouping of domains by their rank
  COUNT(DISTINCT page) AS total_in_rank,  # Total number of unique sites within the rank grouping
  tech.technology AS app,  # Accessibility technology used
  COUNT(DISTINCT IF(category = 'Accessibility', page, NULL)) AS sites_with_app,  # Number of sites using the specific accessibility technology
  COUNT(DISTINCT IF(category = 'Accessibility', page, NULL)) / COUNT(DISTINCT page) AS pct_sites_with_app  # Percentage of sites using the accessibility technology
FROM
  `httparchive.all.pages`,
  UNNEST(technologies) AS tech,  # Expand technologies array to individual rows
  UNNEST(categories) AS category,  # Expand categories array to individual rows
  UNNEST([1000, 10000, 100000, 1000000, 10000000, 100000000]) AS rank_grouping  # Expand rank_grouping to cover different rank categories
WHERE
  date = '2024-06-01' AND
  category = 'Accessibility' AND  # Filter to include only accessibility-related technologies
  rank <= rank_grouping  # Include only sites within the specified rank grouping
GROUP BY
  client,  # Group by client domain
  rank_grouping,  # Group by rank grouping
  tech.technology  # Group by the specific accessibility technology (extracted from STRUCT)
ORDER BY
  tech.technology,  # Order results by technology (app)
  rank_grouping,  # Order results by rank grouping
  client;  # Order results by client domain
