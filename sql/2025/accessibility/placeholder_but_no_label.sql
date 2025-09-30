#standardSQL
# Form controls with placeholder but no label

SELECT
  client,
  is_root_page,
  COUNT(0) AS total_sites,
  COUNTIF(total_placeholder > 0) AS sites_with_placeholder,
  COUNTIF(total_no_label > 0) AS sites_with_no_label, # Has placeholder but no label

  COUNTIF(total_placeholder > 0) / COUNT(0) AS pct_sites_with_placeholder,
  # Sites with placeholders that dont always use labels alongside them
  COUNTIF(total_no_label > 0) / COUNTIF(total_placeholder > 0) AS pct_placeholder_sites_with_no_label,

  SUM(total_placeholder) AS total_placeholders,
  SUM(total_no_label) AS total_placeholder_with_no_label,
  SUM(total_no_label) / SUM(total_placeholder) AS pct_placeholders_with_no_label
FROM (
  SELECT
    client,
    is_root_page,
    CAST(JSON_VALUE(custom_metrics.a11y.placeholder_but_no_label.total_placeholder) AS INT64) AS total_placeholder,
    CAST(JSON_VALUE(custom_metrics.a11y.placeholder_but_no_label.total_no_label) AS INT64) AS total_no_label
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'
)
GROUP BY
  client,
  is_root_page;
