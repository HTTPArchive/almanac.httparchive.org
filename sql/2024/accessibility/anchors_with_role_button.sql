#standardSQL
# Anchors with role='button'
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
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._a11y'), '$.total_anchors_with_role_button') AS INT64) AS total_anchors_with_role_button,
    IFNULL(CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._element_count'), '$.a') AS INT64), 0) AS total_anchors
  FROM
    `httparchive.all.pages`
)
WHERE
  date = '2024-06-01'
GROUP BY
  client,
  is_root_page;
