#standardSQL
# How often pages contain an element with a given attribute

# Temporary function to extract attributes used on elements from the JSON payload
CREATE TEMPORARY FUNCTION getUsedAttributes(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  const almanac = JSON.parse(payload);
  return Object.keys(almanac.attributes_used_on_elements);  // Extract attributes from the JSON structure
} catch (e) {
  return [];
}
''';

# Main query to analyze the usage of specific attributes across sites
WITH attribute_usage AS (
  SELECT
    client,
    is_root_page,
    page,  # Distinct pages
    attribute  # The attribute being analyzed
  FROM
    `httparchive.all.pages`,
    UNNEST(getUsedAttributes(JSON_EXTRACT_SCALAR(payload, '$._almanac'))) AS attribute
  WHERE
    date = '2024-06-01'
)

# Aggregate results to compute totals and percentages
SELECT
  a.client,
  a.is_root_page,
  t.total_sites,  # Total number of unique sites
  a.attribute,  # The attribute being analyzed
  COUNT(DISTINCT a.page) AS total_sites_using,  # Number of unique sites using this attribute
  SAFE_DIVIDE(COUNT(DISTINCT a.page), t.total_sites) AS pct_sites_using  # Percentage of sites using this attribute
FROM
  attribute_usage a
JOIN (
  # Subquery to calculate total unique sites per client and is_root_page
  SELECT
    client,
    is_root_page,
    COUNT(DISTINCT page) AS total_sites
  FROM
    attribute_usage
  GROUP BY
    client,
    is_root_page
) t
ON
  a.client = t.client AND a.is_root_page = t.is_root_page
GROUP BY
  a.client,
  a.is_root_page,
  a.attribute,
  t.total_sites
HAVING
  STARTS_WITH(a.attribute, 'aria-') OR  # Include attributes that start with 'aria-'
  SAFE_DIVIDE(COUNT(DISTINCT a.page), t.total_sites) >= 0.01  # Or include attributes used by 1% or more of sites
ORDER BY
  pct_sites_using DESC;  # Order by percentage in descending order
