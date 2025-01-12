#standardSQL
# Overall Accessibility (A11y) technology, ie. Overlays, usage by domain rank

# Main SELECT statement to aggregate results by client and rank grouping.
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
      `httparchive.all.pages`,
      UNNEST([1000, 10000, 100000, 1000000, 10000000, 100000000]) AS rank_grouping, # Expand rank_grouping to cover different rank categories
      UNNEST(technologies) AS tech,
      UNNEST(categories) AS category
    WHERE
      date = '2024-06-01' AND
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
      `httparchive.all.pages`,
      UNNEST([1000, 10000, 100000, 1000000, 10000000, 100000000]) AS rank_grouping
    WHERE
      date = '2024-06-01' AND
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
