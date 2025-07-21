#standardSQL
# The distribution of page weight by resource type and client, with updated SWDM v4 methodology including both operational and embodied emissions

-- Energy consumption factors from SWDM v4 (in kWh/GB)
DECLARE energy_per_GB_datacenter NUMERIC DEFAULT CAST(0.055 + 0.012 AS NUMERIC); -- Operational + Embodied
DECLARE energy_per_GB_network NUMERIC DEFAULT CAST(0.059 + 0.013 AS NUMERIC); -- Operational + Embodied
DECLARE energy_per_GB_device NUMERIC DEFAULT CAST(0.080 + 0.081 AS NUMERIC); -- Operational + Embodied

-- Total energy consumption per GB, calculated by summing the above factors
DECLARE kw_per_GB NUMERIC DEFAULT CAST(energy_per_GB_datacenter + energy_per_GB_network + energy_per_GB_device AS NUMERIC); -- Sum of all operational and embodied energies

-- Global average carbon intensity of electricity generation (gCO2/kWh)
DECLARE global_grid_intensity NUMERIC DEFAULT 494;

-- Function to calculate emissions in gCO2
CREATE TEMP FUNCTION calculate_emissions(
  bytes FLOAT64,
  kw_per_GB FLOAT64,
  grid_intensity FLOAT64
) RETURNS FLOAT64 AS (
  (bytes / 1024 / 1024 / 1024) *  -- Convert bytes to GB
  (kw_per_GB) *
  grid_intensity
);

WITH page_data AS (
  SELECT
    client,
    CAST(JSON_VALUE(summary, '$.bytesTotal') AS INT64) AS bytesTotal,
    CAST(JSON_VALUE(summary, '$.bytesHtml') AS INT64) AS bytesHtml,
    CAST(JSON_VALUE(summary, '$.bytesJS') AS INT64) AS bytesJS,
    CAST(COALESCE(JSON_VALUE(summary, '$.bytesCss'), JSON_VALUE(summary, '$.bytesStyle')) AS INT64) AS bytesCSS,
    CAST(JSON_VALUE(summary, '$.bytesImg') AS INT64) AS bytesImg,
    CAST(JSON_VALUE(summary, '$.bytesOther') AS INT64) AS bytesOther,
    CAST(JSON_VALUE(summary, '$.bytesHtmlDoc') AS INT64) AS bytesHtmlDoc,
    CAST(JSON_VALUE(summary, '$.bytesFont') AS INT64) AS bytesFont
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-06-01' AND is_root_page
)

SELECT
  percentile,
  client,
  -- For each resource type, calculate the size in KB and the associated emissions
  -- Total resources
  APPROX_QUANTILES(bytesTotal / 1024, 1000) [OFFSET(percentile * 10)] AS total_kbytes,
  APPROX_QUANTILES(calculate_emissions(bytesTotal, kw_per_GB, global_grid_intensity), 1000) [OFFSET(percentile * 10)] AS total_emissions,
  -- HTML resources
  APPROX_QUANTILES(bytesHtml / 1024, 1000) [OFFSET(percentile * 10)] AS html_kbytes,
  APPROX_QUANTILES(calculate_emissions(bytesHtml, kw_per_GB, global_grid_intensity), 1000) [OFFSET(percentile * 10)] AS html_emissions,
  -- JavaScript resources
  APPROX_QUANTILES(bytesJS / 1024, 1000) [OFFSET(percentile * 10)] AS js_kbytes,
  APPROX_QUANTILES(calculate_emissions(bytesJS, kw_per_GB, global_grid_intensity), 1000) [OFFSET(percentile * 10)] AS js_emissions,
  -- CSS resources
  APPROX_QUANTILES(bytesCSS / 1024, 1000) [OFFSET(percentile * 10)] AS css_kbytes,
  APPROX_QUANTILES(calculate_emissions(bytesCSS, kw_per_GB, global_grid_intensity), 1000) [OFFSET(percentile * 10)] AS css_emissions,
  -- Image resources
  APPROX_QUANTILES(bytesImg / 1024, 1000) [OFFSET(percentile * 10)] AS img_kbytes,
  APPROX_QUANTILES(calculate_emissions(bytesImg, kw_per_GB, global_grid_intensity), 1000) [OFFSET(percentile * 10)] AS img_emissions,
  -- Other resources
  APPROX_QUANTILES(bytesOther / 1024, 1000) [OFFSET(percentile * 10)] AS other_kbytes,
  APPROX_QUANTILES(calculate_emissions(bytesOther, kw_per_GB, global_grid_intensity), 1000) [OFFSET(percentile * 10)] AS other_emissions,
  -- HTML document
  APPROX_QUANTILES(bytesHtmlDoc / 1024, 1000) [OFFSET(percentile * 10)] AS html_doc_kbytes,
  APPROX_QUANTILES(calculate_emissions(bytesHtmlDoc, kw_per_GB, global_grid_intensity), 1000) [OFFSET(percentile * 10)] AS html_doc_emissions,
  -- Font resources
  APPROX_QUANTILES(bytesFont / 1024, 1000) [OFFSET(percentile * 10)] AS font_kbytes,
  APPROX_QUANTILES(calculate_emissions(bytesFont, kw_per_GB, global_grid_intensity), 1000) [OFFSET(percentile * 10)] AS font_emissions
FROM
  page_data,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  client,
  percentile
