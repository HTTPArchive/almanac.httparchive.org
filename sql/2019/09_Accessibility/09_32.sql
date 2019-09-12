#standardSQL
# 09_32: Sites properly using alt tags (or role=none and role=presentation) on image and button image elements
SELECT
  COUNT(0) AS total_sites,
  COUNTIF(uses_any_images) AS total_using_any_images,
  COUNTIF(uses_img_elements) AS total_using_img_elements,
  COUNTIF(uses_input_img_elements) AS total_using_input_img_elements,

  ROUND(COUNTIF(uses_img_elements AND good_or_na_image_alts) * 100 / COUNTIF(uses_img_elements), 2) AS perc_good_img_element_alts,
  ROUND(COUNTIF(uses_input_img_elements AND good_or_na_input_img_alts) * 100 / COUNTIF(uses_input_img_elements), 2) AS perc_good_input_img_alts,
  ROUND(COUNTIF(uses_any_images AND good_or_na_image_alts AND good_or_na_input_img_alts) * 100 / COUNTIF(uses_any_images), 2) AS perc_good_img_alts
FROM (
  SELECT
    JSON_EXTRACT_SCALAR(report, '$.audits.image-alt.score') IS NOT NULL AS uses_img_elements,
    JSON_EXTRACT_SCALAR(report, '$.audits.input-image-alt.score') IS NOT NULL AS uses_input_img_elements,
    JSON_EXTRACT_SCALAR(report, '$.audits.image-alt.score') IS NOT NULL OR JSON_EXTRACT_SCALAR(report, '$.audits.input-image-alt.score') IS NOT NULL AS uses_any_images,

    IFNULL(CAST(JSON_EXTRACT_SCALAR(report, '$.audits.image-alt.score') as NUMERIC), 1) = 1 AS good_or_na_image_alts,
    IFNULL(CAST(JSON_EXTRACT_SCALAR(report, '$.audits.input-image-alt.score') as NUMERIC), 1) = 1 AS good_or_na_input_img_alts
  FROM
    `httparchive.lighthouse.2019_07_01_mobile`
)
