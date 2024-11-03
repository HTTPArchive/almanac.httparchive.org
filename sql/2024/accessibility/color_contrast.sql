#standardSQL
# % of pages with sufficient text color contrast with its background
SELECT
  client,
  is_root_page,
  COUNTIF(color_contrast_score IS NOT NULL) AS total_applicable,
  COUNTIF(CAST(color_contrast_score AS NUMERIC) = 1) AS total_good_contrast,
  COUNTIF(CAST(color_contrast_score AS NUMERIC) = 1) / COUNTIF(color_contrast_score IS NOT NULL) AS perc_good_contrast
FROM (
  SELECT
    client,
    is_root_page,
    date,
    JSON_VALUE(lighthouse, '$.audits.color-contrast.score') AS color_contrast_score
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01'
)
GROUP BY
  client,
  is_root_page,
  date
ORDER BY
  client,
  is_root_page;
