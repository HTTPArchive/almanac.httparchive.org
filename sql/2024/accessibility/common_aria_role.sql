#standardSQL
# % of sites using each type of ARIA role

# Temporary function to extract ARIA roles used on a site from the JSON payload
CREATE TEMPORARY FUNCTION getUsedRoles(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  const almanac = JSON.parse(payload);
  return Object.keys(almanac.nodes_using_role.usage_and_count);  // Extract ARIA roles from the JSON structure
} catch (e) {
  return [];
}
''';

# Main query to analyze ARIA role usage across sites
SELECT
  client,  # Derive client domain from the table suffix
  COUNT(DISTINCT page) AS total_sites,  # Total number of unique sites for the client
  role,  # The ARIA role being analyzed
  COUNT(0) AS total_sites_using,  # Number of sites using this specific ARIA role
  SAFE_DIVIDE(COUNT(0), COUNT(DISTINCT page)) AS pct_sites_using  # Percentage of sites using this ARIA role
FROM
  `httparchive.all.pages`,  # Single table containing all the necessary data
  UNNEST(getUsedRoles(JSON_EXTRACT_SCALAR(payload, '$._almanac'))) AS role  # Unnest the ARIA roles extracted from the JSON payload
WHERE
  date = '2024-06-01'  # Filter for the specific date
GROUP BY
  client,  # Group by client domain
  role  # Group by ARIA role
HAVING
  total_sites_using >= 100  # Filter to include only roles used by 100 or more sites
ORDER BY
  pct_sites_using DESC;  # Order results by the percentage of sites using each ARIA role, in descending order
