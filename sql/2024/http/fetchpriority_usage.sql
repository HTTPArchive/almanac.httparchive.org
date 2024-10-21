SELECT
  client,
  is_root_page,
  COUNT(0) AS total_sites,
  COUNTIF(num_priority_hints > 0) AS sites_using_priority_hints,
  COUNTIF(num_priority_hints > 0) / COUNT(0) AS sites_using_priority_hints_pct
FROM (
  SELECT
    client,
    is_root_page,
    page,
    CAST(JSON_EXTRACT_SCALAR(custom_metrics, '$.almanac.priority-hints.total') AS INT64) AS num_priority_hints
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01'
)
GROUP BY
  client,
  is_root_page
ORDER BY
  client,
  is_root_page
