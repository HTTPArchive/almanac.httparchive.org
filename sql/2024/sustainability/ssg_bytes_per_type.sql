#standardSQL
# Median resource weights by CMS

# Declare variables to calculate the carbon emissions of one byte
# Source: https://sustainablewebdesign.org/calculating-digital-emissions/
# The implementation below does not make the assumptions about returning visitors or caching that are present in the Sustainable Web Design model.

DECLARE kw_per_GB NUMERIC DEFAULT 0.81;
DECLARE global_grid_intensity NUMERIC DEFAULT 442;
WITH ssg_data AS (
  SELECT
    client,
    page,
    tech.technology AS ssg,
    CAST(JSON_VALUE(summary, '$.bytesTotal') AS INT64) / 1024 AS total_kb,
    (CAST(JSON_VALUE(summary, '$.bytesTotal') AS INT64) / 1024 / 1024 / 1024) * kw_per_GB * global_grid_intensity AS total_emissions,
    CAST(JSON_VALUE(summary, '$.bytesHtml') AS INT64) / 1024 AS html_kb,
    (CAST(JSON_VALUE(summary, '$.bytesHtml') AS INT64) / 1024 / 1024 / 1024) * kw_per_GB * global_grid_intensity AS total_html_emissions,
    CAST(JSON_VALUE(summary, '$.bytesJS') AS INT64) / 1024 AS js_kb,
    (CAST(JSON_VALUE(summary, '$.bytesJS') AS INT64) / 1024 / 1024 / 1024) * kw_per_GB * global_grid_intensity AS total_js_emissions,
    CAST(JSON_VALUE(summary, '$.bytesCss') AS INT64) / 1024 AS css_kb,
    (CAST(JSON_VALUE(summary, '$.bytesCss') AS INT64) / 1024 / 1024 / 1024) * kw_per_GB * global_grid_intensity AS total_css_emissions,
    CAST(JSON_VALUE(summary, '$.bytesImg') AS INT64) / 1024 AS img_kb,
    (CAST(JSON_VALUE(summary, '$.bytesImg') AS INT64) / 1024 / 1024 / 1024) * kw_per_GB * global_grid_intensity AS total_img_emissions,
    CAST(JSON_VALUE(summary, '$.bytesFont') AS INT64) / 1024 AS font_kb,
    (CAST(JSON_VALUE(summary, '$.bytesFont') AS INT64) / 1024 / 1024 / 1024) * kw_per_GB * global_grid_intensity AS total_font_emissions
  FROM
    `httparchive.all.pages` TABLESAMPLE SYSTEM (0.0001 PERCENT),
  WHERE
    date = '2024-06-01' AND
    AND EXISTS (
      SELECT 1
      FROM UNNEST(technologies) AS tech
      WHERE LOWER(tech.category) = 'static site generator'
      OR tech.technology IN ('Next.js', 'Nuxt.js')
    )
)

SELECT
  client,
  ssg,
  COUNT(0) AS pages,
  APPROX_QUANTILES(total_kb, 1000)[OFFSET(500)] AS median_total_kb,
  APPROX_QUANTILES(total_emissions, 1000)[OFFSET(500)] AS median_total_emissions,
  APPROX_QUANTILES(html_kb, 1000)[OFFSET(500)] AS median_html_kb,
  APPROX_QUANTILES(total_html_emissions, 1000)[OFFSET(500)] AS median_total_html_emissions,
  APPROX_QUANTILES(js_kb, 1000)[OFFSET(500)] AS median_js_kb,
  APPROX_QUANTILES(total_js_emissions, 1000)[OFFSET(500)] AS median_total_js_emissions,
  APPROX_QUANTILES(css_kb, 1000)[OFFSET(500)] AS median_css_kb,
  APPROX_QUANTILES(total_css_emissions, 1000)[OFFSET(500)] AS median_total_css_emissions,
  APPROX_QUANTILES(img_kb, 1000)[OFFSET(500)] AS median_img_kb,
  APPROX_QUANTILES(total_img_emissions, 1000)[OFFSET(500)] AS median_total_img_emissions,
  APPROX_QUANTILES(font_kb, 1000)[OFFSET(500)] AS median_font_kb,
  APPROX_QUANTILES(total_font_emissions, 1000)[OFFSET(500)] AS median_total_font_emissions
FROM
  ssg_data
GROUP BY
  client,
  ssg
ORDER BY
  pages DESC,
  ssg,
  client;
