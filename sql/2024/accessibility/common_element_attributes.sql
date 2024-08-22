#standardSQL
# How often pages contain an element with a given attribute

# Temporary function to extract attributes used on elements from the JSON payload
CREATE TEMPORARY FUNCTION getUsedAttributes(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS """
try {
  const almanac = JSON.parse(payload);
  return Object.keys(almanac.attributes_used_on_elements);  // Extract attributes from the JSON structure
} catch (e) {
  return [];
}
""";

# Main query to analyze the usage of specific attributes across sites
SELECT
  client,  # Derive client domain from the table suffix
  COUNT(DISTINCT page) AS total_sites,  # Total number of unique sites for the client
  attribute,  # The attribute being analyzed
  COUNT(0) AS total_sites_using,  # Number of sites using this specific attribute
  SAFE_DIVIDE(COUNT(0), COUNT(DISTINCT page)) AS pct_sites_using  # Percentage of sites using this attribute
FROM
  `httparchive.all.pages`,  # Single table containing all the necessary data
  UNNEST(getUsedAttributes(JSON_EXTRACT_SCALAR(payload, '$._almanac'))) AS attribute  # Unnest the attributes extracted from the JSON payload
WHERE
  date = '2024-06-01'  # Filter for the specific date
GROUP BY
  client,  # Group by client domain
  attribute  # Group by attribute
HAVING
  STARTS_WITH(attribute, 'aria-') OR  # Include attributes that start with 'aria-'
  SAFE_DIVIDE(COUNT(0), COUNT(DISTINCT page)) >= 0.01  # Or include attributes used by 1% or more of sites
ORDER BY
  pct_sites_using DESC;  # Order results by the percentage of sites using each attribute, in descending order
