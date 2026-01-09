#standardSQL
-- Anchors with role="button" (2025-07-01)
-- Google Sheet: anchors_with_role_button
--
-- Measures how often <a> elements are given role="button".
-- Reports per client and root-page status:
--   • # of sites with anchors
--   • # of sites with at least one anchor role="button"
--   • % of anchor-using sites that apply role="button"
SELECT
  client,
  is_root_page,
  COUNTIF(total_anchors > 0) AS sites_with_anchors,
  COUNTIF(total_anchors_with_role_button > 0) AS sites_with_anchor_role_button,

  # Of sites that have anchors... how many have an anchor with a role='button'
  COUNTIF(total_anchors_with_role_button > 0) / COUNTIF(total_anchors > 0) AS pct_sites_with_anchor_role_button
FROM (
  SELECT
    client,
    is_root_page,
    date,
    CAST(JSON_VALUE(custom_metrics.a11y.total_anchors_with_role_button) AS INT64) AS total_anchors_with_role_button,
    IFNULL(CAST(JSON_VALUE(custom_metrics.element_count.a) AS INT64), 0) AS total_anchors
  FROM
    `httparchive.crawl.pages`
    -- TABLESAMPLE SYSTEM (10 PERCENT)   -- ← optional: cheap smoke test
)
WHERE
  date = '2025-07-01'
GROUP BY
  client,
  is_root_page;
