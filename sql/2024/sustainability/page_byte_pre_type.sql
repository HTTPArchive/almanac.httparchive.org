#standardSQL
# The distribution of page weight by resource type and client, with updated SWDM v4 methodology

-- Energy consumption factors from SWDM v4 (in TWh/ZB)
DECLARE energy_per_GB_datacenter NUMERIC DEFAULT 0.00006829493087557603; # 290 TWh / 5.29 ZB
DECLARE energy_per_GB_network NUMERIC DEFAULT 0.05859598853868195; # 310 TWh / 5.29 ZB
DECLARE energy_per_GB_device NUMERIC DEFAULT 0.07956802188162324; # 421 TWh / 5.29 ZB

-- Total energy consumption per GB, calculated by summing the above factors and converting to kWh/GB
DECLARE kw_per_GB NUMERIC DEFAULT 0.19300566251415094; # (290 + 310 + 421) TWh / 5.29 ZB * 1000000 kWh/TWh / 1000000000 GB/ZB

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
    httparchive.all.pages
  WHERE
    date = '2024-06-01'  
    AND is_root_page     
)

SELECT
  percentile,
  client,
  -- For each resource type, calculate the size in KB and the associated emissions
  -- Total resources
  APPROX_QUANTILES(bytesTotal / 1024, 1000)[OFFSET(percentile * 10)] AS total_kbytes,
  APPROX_QUANTILES(calculate_emissions(bytesTotal, kw_per_GB, global_grid_intensity), 1000)[OFFSET(percentile * 10)] AS total_emissions,
  -- HTML resources
  APPROX_QUANTILES(bytesHtml / 1024, 1000)[OFFSET(percentile * 10)] AS html_kbytes,
  APPROX_QUANTILES(calculate_emissions(bytesHtml, kw_per_GB, global_grid_intensity), 1000)[OFFSET(percentile * 10)] AS html_emissions,
  -- JavaScript resources
  APPROX_QUANTILES(bytesJS / 1024, 1000)[OFFSET(percentile * 10)] AS js_kbytes,
  APPROX_QUANTILES(calculate_emissions(bytesJS, kw_per_GB, global_grid_intensity), 1000)[OFFSET(percentile * 10)] AS js_emissions,
  -- CSS resources
  APPROX_QUANTILES(bytesCSS / 1024, 1000)[OFFSET(percentile * 10)] AS css_kbytes,
  APPROX_QUANTILES(calculate_emissions(bytesCSS, kw_per_GB, global_grid_intensity), 1000)[OFFSET(percentile * 10)] AS css_emissions,
  -- Image resources
  APPROX_QUANTILES(bytesImg / 1024, 1000)[OFFSET(percentile * 10)] AS img_kbytes,
  APPROX_QUANTILES(calculate_emissions(bytesImg, kw_per_GB, global_grid_intensity), 1000)[OFFSET(percentile * 10)] AS img_emissions,
  -- Other resources
  APPROX_QUANTILES(bytesOther / 1024, 1000)[OFFSET(percentile * 10)] AS other_kbytes,
  APPROX_QUANTILES(calculate_emissions(bytesOther, kw_per_GB, global_grid_intensity), 1000)[OFFSET(percentile * 10)] AS other_emissions,
  -- HTML document
  APPROX_QUANTILES(bytesHtmlDoc / 1024, 1000)[OFFSET(percentile * 10)] AS html_doc_kbytes,
  APPROX_QUANTILES(calculate_emissions(bytesHtmlDoc, kw_per_GB, global_grid_intensity), 1000)[OFFSET(percentile * 10)] AS html_doc_emissions,
  -- Font resources
  APPROX_QUANTILES(bytesFont / 1024, 1000)[OFFSET(percentile * 10)] AS font_kbytes,
  APPROX_QUANTILES(calculate_emissions(bytesFont, kw_per_GB, global_grid_intensity), 1000)[OFFSET(percentile * 10)] AS font_emissions
FROM
  page_data,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  client,
  percentile
