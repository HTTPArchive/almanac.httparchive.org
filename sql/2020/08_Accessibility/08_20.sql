#standardSQL
# 08_20: Sites using sr-only or visually-hidden classes
SELECT
  client,
  COUNT(0) AS total_sites,
  COUNTIF(uses_sr_only) AS sites_with_sr_only,
  ROUND((COUNTIF(uses_sr_only) / COUNT(0)) * 100, 2) AS pct_sites_with_sr_only
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, "$._a11y"), "$.does_page_use_sr_only_classes") AS BOOL) AS uses_sr_only
  FROM
    `httparchive.almanac.pages_desktop_*`
)
GROUP BY
  client
