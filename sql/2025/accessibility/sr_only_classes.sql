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
    CAST(JSON_VALUE(custom_metrics.a11y.screen_reader_classes) AS BOOL) AS uses_sr_only
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'
)
GROUP BY
  client,
  is_root_page;
