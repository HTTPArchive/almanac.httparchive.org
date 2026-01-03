#standardSQL
# Web Almanac — % of sites using each HTML attribute (2025-07-01; no JS UDF)
# Google Sheet: common_element_attributes
#
# Purpose
#   • Analyze how often sites use specific HTML attributes.
#   • Focus on ARIA attributes plus any attribute used by ≥1% of sites.
#
# Method
#   1. Read attribute usage summary from 2025 Almanac JSON:
#        custom_metrics.other.almanac.attributes_used_on_elements
#   2. Expand attribute names with JSON_KEYS() → one row per {page, attribute}.
#   3. Count distinct sites per {client, is_root_page, attribute}.
#   4. Compute percentage of sites using each attribute relative to group totals.
#   5. Keep only attributes starting with "aria-" or used by ≥1% of sites.
#
# Output columns
#   client              — "desktop" | "mobile"
#   is_root_page        — TRUE if root page
#   total_sites         — distinct sites in group
#   attribute           — attribute name
#   total_sites_using   — sites with that attribute
#   pct_sites_using     — share of sites using that attribute (0–1)
#
# Changes from older version
#   • Removed JavaScript UDF (getUsedAttributes).
#   • Now use native BigQuery JSON functions:
#       JSON_QUERY() to isolate the attributes object,
#       JSON_KEYS() to extract attribute names.
#   • Read from `custom_metrics.other.almanac` instead of payload._almanac.
# Extract attributes used on elements directly from the 2025 Almanac JSON
WITH attribute_usage AS (
  SELECT
    client,
    is_root_page,
    page,                              -- Distinct pages
    attribute                          -- The attribute being analyzed
  FROM
    `httparchive.crawl.pages`,
    -- `httparchive.sample_data.pages_10k`,
    UNNEST(
      JSON_KEYS(
        JSON_QUERY(custom_metrics.other.almanac, '$.attributes_used_on_elements')
      )
    ) AS attribute
  WHERE
    date = DATE '2025-07-01' AND
    custom_metrics.other.almanac IS NOT NULL
),

# Totals per {client, is_root_page}
total_sites_per_group AS (
  SELECT
    client,
    is_root_page,
    COUNT(DISTINCT page) AS total_sites
  FROM attribute_usage
  GROUP BY client, is_root_page
)

# Aggregate results to compute totals and percentages
SELECT
  a.client,
  a.is_root_page,
  t.total_sites,                                -- Total number of unique sites
  a.attribute,                                  -- The attribute being analyzed
  COUNT(DISTINCT a.page) AS total_sites_using,  -- Sites using this attribute
  SAFE_DIVIDE(COUNT(DISTINCT a.page), t.total_sites) AS pct_sites_using
FROM attribute_usage a
JOIN total_sites_per_group t
ON a.client = t.client AND a.is_root_page = t.is_root_page
GROUP BY
  a.client, a.is_root_page, a.attribute, t.total_sites
HAVING
  STARTS_WITH(a.attribute, 'aria-') OR          -- keep aria-* always
  SAFE_DIVIDE(COUNT(DISTINCT a.page), t.total_sites) >= 0.01  -- or ≥1% of sites
ORDER BY pct_sites_using DESC;
