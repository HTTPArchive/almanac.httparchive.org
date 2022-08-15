#standardSQL
# % of pages with sufficient text color contrast with its background
SELECT
  client,
  COUNTIF(color_contrast_score IS NOT NULL) AS total_applicable,
  COUNTIF(CAST(color_contrast_score AS NUMERIC) = 1) AS total_good_contrast,
  COUNTIF(CAST(color_contrast_score AS NUMERIC) = 1) / COUNTIF(color_contrast_score IS NOT NULL) AS perc_good_contrast
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    JSON_EXTRACT_SCALAR(report, '$.audits.color-contrast.score') AS color_contrast_score
  FROM
    `httparchive.lighthouse.2022_06_01_*`
)
GROUP BY
  client
ORDER BY
  client
