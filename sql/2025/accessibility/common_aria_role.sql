#standardSQL
# Web Almanac — % of sites using each ARIA role (2025 schema; no JS UDF)
# Google Sheet: common_aria_role
#
# What this query does
#   • Reads ARIA role usage keys from 2025 almanac JSON at:
#       custom_metrics.other.almanac.nodes_using_role.usage_and_count
#   • Expands keys (role names) with JSON_KEYS() → one row per {page, role}.
#   • Aggregates by {client, is_root_page} to compute:
#       - total_sites           — distinct pages in group
#       - total_sites_using     — distinct pages using each role
#       - pct_sites_using       — total_sites_using / total_sites
#   • Filters to roles used by ≥ 100 sites.
#
# Output columns
#   client              — "desktop" | "mobile"
#   is_root_page        — TRUE only (filtered)
#   total_sites         — distinct pages per {client, is_root_page}
#   role                — ARIA role name
#   total_sites_using   — distinct pages using that role
#   pct_sites_using     — share of sites using that role (0–1)
#
# Cost & safety
#   • No JS UDF; fully native JSON functions (JSON_QUERY + JSON_KEYS).
#   • Restricts scan via date = DATE '2025-07-01' and is_root_page = TRUE.
#   • For smoke tests, swap in `httparchive.sample_data.pages_10k` and
#     comment out the date filter.
WITH src AS (
  SELECT
    client,
    is_root_page,
    page,
    -- pull just the object we want (usage_and_count) out of almanac
    JSON_QUERY(custom_metrics.other.almanac, '$.nodes_using_role.usage_and_count') AS usage_and_count
  FROM
    `httparchive.crawl.pages`
    -- `httparchive.sample_data.pages_10k`
  WHERE
    is_root_page = TRUE AND
    custom_metrics.other.almanac IS NOT NULL AND
    date = DATE '2025-07-01' -- Comment out if using `httparchive.sample_data.pages_10k`
),

role_usage AS (
  SELECT
    client,
    is_root_page,
    page,
    role
  FROM src
  CROSS JOIN UNNEST(JSON_KEYS(usage_and_count)) AS role
),

totals AS (
  SELECT client, is_root_page, COUNT(DISTINCT page) AS total_sites
  FROM role_usage
  GROUP BY client, is_root_page
)

SELECT
  r.client,
  r.is_root_page,
  t.total_sites,
  r.role,
  COUNT(DISTINCT r.page) AS total_sites_using,
  SAFE_DIVIDE(COUNT(DISTINCT r.page), t.total_sites) AS pct_sites_using
FROM
  role_usage r
JOIN
  totals t
USING (client, is_root_page)
GROUP BY r.client, r.is_root_page, t.total_sites, r.role
HAVING
  total_sites_using >= 100
ORDER BY
  pct_sites_using DESC;
