#standardSQL
# Usage of native lazy loading
SELECT
  client,
  COUNTIF(total_img > 0) AS sites_with_images,

  COUNTIF(total_loading_attribute > 0) AS sites_using_loading_attribute,
  COUNTIF(total_loading_attribute > 0) / COUNTIF(total_img > 0) AS pct_sites_using_loading_attribute
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    SAFE_CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._almanac'), '$.images.imgs.total') AS INT64) AS total_img,
    SAFE_CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._almanac'), '$.images.imgs.attribute_usage_count.loading') AS INT64) AS total_loading_attribute
  FROM
    `httparchive.pages.2020_08_01_*`
)
GROUP BY
  client
