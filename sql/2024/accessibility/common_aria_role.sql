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

# Extract ARIA role usage per page
WITH role_usage AS (
  SELECT
    client,
    is_root_page,
    page,  # Distinct pages
    role  # The ARIA role being analyzed
  FROM
    `httparchive.all.pages`,
    UNNEST(getUsedRoles(JSON_EXTRACT_SCALAR(payload, '$._almanac'))) AS role
  WHERE
    date = '2024-06-01'  # Filter for the specific date
),

# Calculate total sites for each client and is_root_page combination
total_sites_per_group AS (
  SELECT
    client,
    is_root_page,
    COUNT(DISTINCT page) AS total_sites  # Total number of unique sites
  FROM
    role_usage
  GROUP BY
    client,
    is_root_page
)

# Aggregate the results to compute totals and percentages
SELECT
  r.client,
  r.is_root_page,
  t.total_sites,  # Total number of unique sites
  r.role,  # The ARIA role being analyzed
  COUNT(DISTINCT r.page) AS total_sites_using,  # Number of unique sites using this ARIA role
  SAFE_DIVIDE(COUNT(DISTINCT r.page), t.total_sites) AS pct_sites_using  # Correct percentage of sites using this ARIA role
FROM
  role_usage r
JOIN
  total_sites_per_group t  # Join to get the total number of unique sites for each group
ON
  r.client = t.client AND r.is_root_page = t.is_root_page
GROUP BY
  r.client,
  r.is_root_page,
  t.total_sites,
  r.role
HAVING
  total_sites_using >= 100  # Filter to include only roles used by 100 or more sites
ORDER BY
  pct_sites_using DESC;  # Order results by percentage of sites using each ARIA role
