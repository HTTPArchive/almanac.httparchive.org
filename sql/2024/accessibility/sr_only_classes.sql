#standardSQL
# Sites using sr-only or visually-hidden classes

SELECT
  client,
  is_root_page,
  COUNT(0) AS total_sites,
  COUNTIF(uses_sr_only) AS sites_with_sr_only,
  COUNTIF(uses_sr_only) / COUNT(0) AS pct_sites_with_sr_only
FROM (
  SELECT
    client,
    is_root_page,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._a11y'), '$.screen_reader_classes') AS BOOL) AS uses_sr_only
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01'
)
GROUP BY
  client,
  is_root_page;
