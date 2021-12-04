#standardSQL
# Use of picture, source and srcset
SELECT
  client,
  COUNTIF(total_img > 0) AS sites_with_images,

  COUNTIF(total_picture > 0) AS sites_with_picture,
  COUNTIF(total_source > 0) AS sites_with_source,
  COUNTIF(total_srcset > 0) AS sites_with_srcset,

  COUNTIF(total_picture > 0) / COUNTIF(total_img > 0) AS pct_sites_with_picture,
  COUNTIF(total_source > 0) / COUNTIF(total_img > 0) AS pct_sites_with_source,
  COUNTIF(total_srcset > 0) / COUNTIF(total_img > 0) AS pct_sites_with_srcset
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._almanac'), '$.images.imgs.total') AS INT64) AS total_img,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._almanac'), '$.images.pictures.total') AS INT64) AS total_picture,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._almanac'), '$.images.sources.total') AS INT64) AS total_source,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._almanac'), '$.images.total_with_srcset') AS INT64) AS total_srcset
  FROM
    `httparchive.pages.2020_08_01_*`
)
GROUP BY
  client
