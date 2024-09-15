#standardSQL
# Median resource weights by ecommerce platform with detailed CO2e breakdown, aggregated by root_page

# Declare variables to calculate the carbon emissions per gigabyte (kWh/GB)
DECLARE grid_intensity NUMERIC DEFAULT 494;
DECLARE embodied_emissions_data_centers NUMERIC DEFAULT 0.012;
DECLARE embodied_emissions_network NUMERIC DEFAULT 0.013;
DECLARE embodied_emissions_user_devices NUMERIC DEFAULT 0.081;
DECLARE operational_emissions_data_centers NUMERIC DEFAULT 0.055;
DECLARE operational_emissions_network NUMERIC DEFAULT 0.059;
DECLARE operational_emissions_user_devices NUMERIC DEFAULT 0.080;

WITH ecommerce_data AS (
  SELECT
    root_page, 
    client,
    tech.technology AS ecommerce,

    -- Aggregate total_kb and CO2e emissions by root_page
    SUM(CAST(JSON_VALUE(summary, '$.bytesTotal') AS INT64)) / 1024 AS total_kb,

    -- Operational emissions calculations aggregated
    SUM((CAST(JSON_VALUE(summary, '$.bytesTotal') AS INT64) / 1024 / 1024 / 1024) * operational_emissions_data_centers * grid_intensity) AS op_emissions_dc,
    SUM((CAST(JSON_VALUE(summary, '$.bytesTotal') AS INT64) / 1024 / 1024 / 1024) * operational_emissions_network * grid_intensity) AS op_emissions_networks,
    SUM((CAST(JSON_VALUE(summary, '$.bytesTotal') AS INT64) / 1024 / 1024 / 1024) * operational_emissions_user_devices * grid_intensity) AS op_emissions_devices,

    -- Embodied emissions calculations aggregated
    SUM((CAST(JSON_VALUE(summary, '$.bytesTotal') AS INT64) / 1024 / 1024 / 1024) * embodied_emissions_data_centers * grid_intensity) AS em_emissions_dc,
    SUM((CAST(JSON_VALUE(summary, '$.bytesTotal') AS INT64) / 1024 / 1024 / 1024) * embodied_emissions_network * grid_intensity) AS em_emissions_networks,
    SUM((CAST(JSON_VALUE(summary, '$.bytesTotal') AS INT64) / 1024 / 1024 / 1024) * embodied_emissions_user_devices * grid_intensity) AS em_emissions_devices,

    -- Total aggregated emissions (operational + embodied)
    SUM(
      (CAST(JSON_VALUE(summary, '$.bytesTotal') AS INT64) / 1024 / 1024 / 1024) * (
        operational_emissions_data_centers + operational_emissions_network + operational_emissions_user_devices +
        embodied_emissions_data_centers + embodied_emissions_network + embodied_emissions_user_devices
      ) * grid_intensity
    ) AS total_emissions,

    -- Aggregated resource sizes in KB
    SUM(CAST(JSON_VALUE(summary, '$.bytesHtml') AS INT64)) / 1024 AS html_kb,
    SUM(CAST(JSON_VALUE(summary, '$.bytesJS') AS INT64)) / 1024 AS js_kb,
    SUM(CAST(JSON_VALUE(summary, '$.bytesCss') AS INT64)) / 1024 AS css_kb,
    SUM(CAST(JSON_VALUE(summary, '$.bytesImg') AS INT64)) / 1024 AS img_kb,
    SUM(CAST(JSON_VALUE(summary, '$.bytesFont') AS INT64)) / 1024 AS font_kb,

    -- Resource-specific emissions calculations (operational + embodied)
    SUM(
      SAFE_DIVIDE(CAST(JSON_VALUE(summary, '$.bytesHtml') AS INT64), CAST(JSON_VALUE(summary, '$.bytesTotal') AS INT64)) *
      (CAST(JSON_VALUE(summary, '$.bytesTotal') AS INT64) / 1024 / 1024 / 1024) * (
        operational_emissions_data_centers + operational_emissions_network + operational_emissions_user_devices +
        embodied_emissions_data_centers + embodied_emissions_network + embodied_emissions_user_devices
      ) * grid_intensity
    ) AS total_html_emissions,

    SUM(
      SAFE_DIVIDE(CAST(JSON_VALUE(summary, '$.bytesJS') AS INT64), CAST(JSON_VALUE(summary, '$.bytesTotal') AS INT64)) *
      (CAST(JSON_VALUE(summary, '$.bytesTotal') AS INT64) / 1024 / 1024 / 1024) * (
        operational_emissions_data_centers + operational_emissions_network + operational_emissions_user_devices +
        embodied_emissions_data_centers + embodied_emissions_network + embodied_emissions_user_devices
      ) * grid_intensity
    ) AS total_js_emissions,

    SUM(
      SAFE_DIVIDE(CAST(JSON_VALUE(summary, '$.bytesCss') AS INT64), CAST(JSON_VALUE(summary, '$.bytesTotal') AS INT64)) *
      (CAST(JSON_VALUE(summary, '$.bytesTotal') AS INT64) / 1024 / 1024 / 1024) * (
        operational_emissions_data_centers + operational_emissions_network + operational_emissions_user_devices +
        embodied_emissions_data_centers + embodied_emissions_network + embodied_emissions_user_devices
      ) * grid_intensity
    ) AS total_css_emissions,

    SUM(
      SAFE_DIVIDE(CAST(JSON_VALUE(summary, '$.bytesImg') AS INT64), CAST(JSON_VALUE(summary, '$.bytesTotal') AS INT64)) *
      (CAST(JSON_VALUE(summary, '$.bytesTotal') AS INT64) / 1024 / 1024 / 1024) * (
        operational_emissions_data_centers + operational_emissions_network + operational_emissions_user_devices +
        embodied_emissions_data_centers + embodied_emissions_network + embodied_emissions_user_devices
      ) * grid_intensity
    ) AS total_img_emissions,

    SUM(
      SAFE_DIVIDE(CAST(JSON_VALUE(summary, '$.bytesFont') AS INT64), CAST(JSON_VALUE(summary, '$.bytesTotal') AS INT64)) *
      (CAST(JSON_VALUE(summary, '$.bytesTotal') AS INT64) / 1024 / 1024 / 1024) * (
        operational_emissions_data_centers + operational_emissions_network + operational_emissions_user_devices +
        embodied_emissions_data_centers + embodied_emissions_network + embodied_emissions_user_devices
      ) * grid_intensity
    ) AS total_font_emissions

  FROM
    `httparchive.all.pages`,
    UNNEST(technologies) AS tech
  WHERE
    date = '2024-06-01' AND
    EXISTS (
      SELECT 1
      FROM UNNEST(tech.categories) AS category
      WHERE category = 'Ecommerce'
      AND tech.technology NOT IN('Cart Functionality', 'Google Analytics Enhanced eCommerce')
    )
  GROUP BY
    root_page, client, tech.technology  -- Group by root_page, client, and ecommerce type
)

SELECT
  client,
  ecommerce,
  COUNT(DISTINCT root_page) AS total_sites,  -- Count distinct root pages

  -- Median resource weights and emissions
  APPROX_QUANTILES(total_kb, 1000)[OFFSET(500)] AS median_total_kb,
  APPROX_QUANTILES(op_emissions_dc + op_emissions_networks + op_emissions_devices, 1000)[OFFSET(500)] AS median_operational_emissions,
  APPROX_QUANTILES(em_emissions_dc + em_emissions_networks + em_emissions_devices, 1000)[OFFSET(500)] AS median_embodied_emissions,
  APPROX_QUANTILES(total_emissions, 1000)[OFFSET(500)] AS median_total_emissions,

  -- Resource-specific medians
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
  ecommerce_data
GROUP BY
  client,
  ecommerce
ORDER BY
  total_sites DESC,
  ecommerce,
  client;
