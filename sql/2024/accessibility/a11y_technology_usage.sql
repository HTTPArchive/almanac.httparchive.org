#standardSQL
# Accessibility (A11y) technology, ie. Overlays, usage by client

SELECT
  client,  # Client domain
  is_root_page,
  COUNT(DISTINCT page) AS total_sites,  # Total number of unique sites for the client
  COUNT(DISTINCT IF(category = 'Accessibility', page, NULL)) AS sites_with_a11y_tech,  # Number of unique sites that use accessibility technology
  COUNT(DISTINCT IF(category = 'Accessibility', page, NULL)) / COUNT(DISTINCT page) AS pct_sites_with_a11y_tech  # Percentage of sites using accessibility technology
FROM
  `httparchive.all.pages`,
  UNNEST(technologies) AS tech,
  UNNEST(categories) AS category
WHERE
  date = '2024-06-01' # Specific date for data extraction
GROUP BY
  client,
  is_root_page
ORDER BY
  client,
  is_root_page;
