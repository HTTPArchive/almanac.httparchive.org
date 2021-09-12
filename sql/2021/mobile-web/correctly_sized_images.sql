#standardSQL
# pages with perfect scores on the properly sized images audit
SELECT
  COUNTIF(properly_sized_images_score IS NOT NULL) AS total_applicable,
  COUNTIF(properly_sized_images_score = 1) AS total_with_properly_sized_images,
  COUNTIF(properly_sized_images_score = 1) / COUNTIF(properly_sized_images_score IS NOT NULL) AS pct_with_properly_sized_images
FROM (
  SELECT
    SAFE_CAST(JSON_EXTRACT_SCALAR(report, '$.audits.uses-responsive-images.score') AS NUMERIC) AS properly_sized_images_score
  FROM
    `httparchive.lighthouse.2021_07_01_mobile`
)
