#standardSQL
# Median resource weights by CMS

# Declare variables to calculate the carbon emissions of one byte
# Source: https://sustainablewebdesign.org/calculating-digital-emissions/
# The implementation below does not make the assumptions about returning visitors or caching that are present in the Sustainable Web Design model.

DECLARE kw_per_GB NUMERIC DEFAULT 0.81;
DECLARE global_grid_intensity NUMERIC DEFAULT 442;

SELECT
  client,
  cms,
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
FROM (
  SELECT DISTINCT
    _TABLE_SUFFIX AS client,
    url,
    app AS cms
  FROM
    `httparchive.technologies.2022_06_01_*`
  WHERE
    category = 'CMS'
)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    bytesTotal / 1024 AS total_kb, (bytesTotal / 1024 / 1024 / 1024) * kw_per_GB * global_grid_intensity AS total_emissions,
    bytesHtml / 1024 AS html_kb, (bytesHtml / 1024 / 1024 / 1024) * kw_per_GB * global_grid_intensity AS total_html_emissions,
    bytesJS / 1024 AS js_kb, (bytesJS / 1024 / 1024 / 1024) * kw_per_GB * global_grid_intensity AS total_js_emissions,
    bytesCSS / 1024 AS css_kb, (bytesCSS / 1024 / 1024 / 1024) * kw_per_GB * global_grid_intensity AS total_css_emissions,
    bytesImg / 1024 AS img_kb, (bytesImg / 1024 / 1024 / 1024) * kw_per_GB * global_grid_intensity AS total_img_emissions,
    bytesFont / 1024 AS font_kb, (bytesFont / 1024 / 1024 / 1024) * kw_per_GB * global_grid_intensity AS total_font_emissions
  FROM
    `httparchive.summary_pages.2022_06_01_*`
)
USING (client, url)
GROUP BY
  client,
  cms
ORDER BY
  pages DESC,
  cms,
  client
