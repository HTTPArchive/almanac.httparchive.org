#standardSQL
# Sites containing elements with role='tab', aria-selected and aria-controls attributes
SELECT
  client,
  COUNT(0) AS total_sites,

  COUNTIF(total_tab_selected_controls > 0) AS total_with_tab_selected_controls,
  COUNTIF(total_tab_selected_controls > 0) / COUNT(0) AS pct_with_tab_selected_controls
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._a11y'), '$.total_role_tab_with_selected_and_controls') AS INT64) AS total_tab_selected_controls
  FROM
    `httparchive.pages.2021_07_01_*`
)
GROUP BY
  client
