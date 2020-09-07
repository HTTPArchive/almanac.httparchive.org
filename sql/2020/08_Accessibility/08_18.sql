#standardSQL
# 08_18: How often do form controls have a placeholder but no label
SELECT
  client,
  COUNT(0) AS total_sites,
  COUNTIF(total_placeholder > 0) AS sites_with_placeholder,
  COUNTIF(total_no_label > 0) AS sites_with_no_label, # Has placeholder but no label

  ROUND((COUNTIF(total_placeholder > 0) / COUNT(0)) * 100, 2) AS pct_sites_with_placeholder,
  # Sites with placeholders that dont always use labels alongside them
  ROUND((COUNTIF(total_no_label > 0) / COUNTIF(total_placeholder > 0)) * 100, 2) AS pct_placeholder_sites_with_no_label,

  SUM(total_placeholder) AS total_placeholders,
  SUM(total_no_label) AS total_placeholder_with_no_label,
  ROUND((SUM(total_no_label) / SUM(total_placeholder)) * 100, 2) AS pct_placeholders_with_no_label
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, "$._a11y"), "$.placeholder_but_no_label.total_placeholder") AS INT64) AS total_placeholder,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, "$._a11y"), "$.placeholder_but_no_label.total_no_label") AS INT64) AS total_no_label
  FROM
    `httparchive.almanac.pages_desktop_*`
)
GROUP BY
  client
