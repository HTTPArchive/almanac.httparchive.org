-- HTTP Archive Almanac: <a> with role="button"
--
-- Purpose:
--   This query measures how many websites use <a> (anchor) elements with
--   role="button" attributes, relative to the total number of anchor tags.
--
-- Dataset:
--   `httparchive.crawl.pages` on date = '2025-07-01'
--
-- Key fields used:
--   - custom_metrics.a11y.total_anchors_with_role_button:
--       Count of anchor elements that declare role="button".
--   - custom_metrics.element_count.a:
--       Total count of <a> elements per page.
--   - URL extraction:
--       Multiple fallbacks are used to extract the canonical URL for de-duping:
--         1. custom_metrics.performance.lcp_resource.documentURL
--         2. custom_metrics.canonicals.url (via JSON)
--         3. payload.url
--         4. payload._url
--
-- Aggregation logic:
--   - We restrict to is_root_page = TRUE so each site is counted once.
--   - Hosts are extracted with NET.HOST(url_str).
--   - sites_with_any_a:
--       Distinct hosts with at least one <a>.
--   - sites_with_a_role_button:
--       Distinct hosts with at least one <a role="button">.
--   - pct_sites_with_a_role_button:
--       Fraction of sites_with_a_role_button / sites_with_any_a.
--
-- Safety:
--   - SAFE_CAST used to convert JSON strings into INT64, preventing query errors.
--   - SAFE_DIVIDE avoids division-by-zero.
--
-- Output:
--   client | sites_with_any_a | sites_with_a_role_button | pct_sites_with_a_role_button

WITH base AS (
  SELECT
    client,
    is_root_page,
    COALESCE(
      JSON_VALUE(custom_metrics.performance, '$.lcp_resource.documentURL'),
      JSON_VALUE(TO_JSON_STRING(custom_metrics), '$.canonicals.url'),
      JSON_VALUE(payload, '$.url'),
      JSON_VALUE(payload, '$._url')
    ) AS url_str,
    SAFE_CAST(JSON_VALUE(custom_metrics.a11y, '$.total_anchors_with_role_button') AS INT64)
      AS anchors_role_button,
    SAFE_CAST(JSON_VALUE(TO_JSON_STRING(custom_metrics), '$.element_count.a') AS INT64)
      AS total_a_elements
  FROM `httparchive.crawl.pages`
  WHERE date = '2025-07-01'
)
SELECT
  client,
  COUNT(DISTINCT IF(
      total_a_elements > 0
      AND url_str IS NOT NULL
      AND (STARTS_WITH(url_str, 'http://') OR STARTS_WITH(url_str, 'https://')),
      NET.HOST(url_str), NULL)) AS sites_with_any_a,
  COUNT(DISTINCT IF(
      anchors_role_button > 0
      AND url_str IS NOT NULL
      AND (STARTS_WITH(url_str, 'http://') OR STARTS_WITH(url_str, 'https://')),
      NET.HOST(url_str), NULL)) AS sites_with_a_role_button,
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
        anchors_role_button > 0
        AND url_str IS NOT NULL
        AND (STARTS_WITH(url_str, 'http://') OR STARTS_WITH(url_str, 'https://')),
        NET.HOST(url_str), NULL)),
    COUNT(DISTINCT IF(
        total_a_elements > 0
        AND url_str IS NOT NULL
        AND (STARTS_WITH(url_str, 'http://') OR STARTS_WITH(url_str, 'https://')),
        NET.HOST(url_str), NULL))
  ) AS pct_sites_with_a_role_button
FROM base
WHERE is_root_page
GROUP BY client;
