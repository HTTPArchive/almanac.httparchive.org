#standardSQL

-- Energy consumption factors from SWDM v4 (in TWh/ZB)
# 290 TWh / 5.29 ZB
DECLARE ENERGY_PER_GB_DATACENTER NUMERIC DEFAULT 0.00006829493087557603;
# 310 TWh / 5.29 ZB
DECLARE ENERGY_PER_GB_NETWORK NUMERIC DEFAULT 0.05859598853868195;
# 421 TWh / 5.29 ZB
DECLARE ENERGY_PER_GB_DEVICE NUMERIC DEFAULT 0.07956802188162324;

# (290 + 310 + 421) TWh / 5.29 ZB * 1000000 kWh/TWh / 1000000000 GB/ZB
DECLARE KW_PER_GB NUMERIC DEFAULT 0.19300566251415094;

-- Global average carbon intensity of electricity generation (gCO2/kWh)
DECLARE GLOBAL_GRID_INTENSITY NUMERIC DEFAULT 494;

-- Function to calculate emissions in gCO2
CREATE TEMP FUNCTION calculate_emissions(
  bytes FLOAT64,
  kw_per_GB FLOAT64,
  grid_intensity FLOAT64
) RETURNS FLOAT64 AS (
  (BYTES / 1024 / 1024 / 1024) *  -- Convert bytes to GB
  (KW_PER_GB) *
  GRID_INTENSITY
);

WITH PAGE_DATA AS (
  SELECT
    CLIENT,
    cast(json_value(SUMMARY, '$.bytesTotal') AS INT64) AS BYTESTOTAL,
    cast(json_value(SUMMARY, '$.bytesHtml') AS INT64) AS BYTESHTML,
    cast(
      coalesce(
        json_value(SUMMARY, '$.bytesCss'),
        json_value(SUMMARY, '$.bytesStyle')
      ) AS INT64
    ) AS BYTESCSS,
    cast(json_value(SUMMARY, '$.bytesJS') AS INT64) AS BYTESJS,
    cast(json_value(SUMMARY, '$.bytesImg') AS INT64) AS BYTESIMG,
    cast(json_value(SUMMARY, '$.bytesOther') AS INT64) AS BYTESOTHER,
    cast(json_value(SUMMARY, '$.bytesHtmlDoc') AS INT64) AS BYTESHTMLDOC,
    cast(json_value(SUMMARY, '$.bytesFont') AS INT64) AS BYTESFONT
  FROM
    `httparchive.crawl.pages`
  WHERE
    DATE = '2025-07-01' AND IS_ROOT_PAGE
)

SELECT
  PERCENTILE,
  CLIENT,
  -- Total resources
  approx_quantiles(
    BYTESTOTAL / 1024, 1000
  )[offset(PERCENTILE * 10)] AS TOTAL_KBYTES,
  approx_quantiles(
    calculate_emissions(BYTESTOTAL, KW_PER_GB, GLOBAL_GRID_INTENSITY), 1000
  )[offset(PERCENTILE * 10)] AS TOTAL_EMISSIONS,
  -- HTML resources
  approx_quantiles(
    BYTESHTML / 1024, 1000
  )[offset(PERCENTILE * 10)] AS HTML_KBYTES,
  approx_quantiles(
    calculate_emissions(BYTESHTML, KW_PER_GB, GLOBAL_GRID_INTENSITY), 1000
  )[offset(PERCENTILE * 10)] AS HTML_EMISSIONS,
  -- JavaScript resources
  approx_quantiles(
    BYTESJS / 1024, 1000
  )[offset(PERCENTILE * 10)] AS JS_KBYTES,
  approx_quantiles(
    calculate_emissions(BYTESJS, KW_PER_GB, GLOBAL_GRID_INTENSITY), 1000
  )[offset(PERCENTILE * 10)] AS JS_EMISSIONS,
  -- CSS resources
  approx_quantiles(
    BYTESCSS / 1024, 1000
  )[offset(PERCENTILE * 10)] AS CSS_KBYTES,
  approx_quantiles(
    calculate_emissions(BYTESCSS, KW_PER_GB, GLOBAL_GRID_INTENSITY), 1000
  )[offset(PERCENTILE * 10)] AS CSS_EMISSIONS,
  -- Image resources
  approx_quantiles(
    BYTESIMG / 1024, 1000
  )[offset(PERCENTILE * 10)] AS IMG_KBYTES,
  approx_quantiles(
    calculate_emissions(BYTESIMG, KW_PER_GB, GLOBAL_GRID_INTENSITY), 1000
  )[offset(PERCENTILE * 10)] AS IMG_EMISSIONS,
  -- Other resources
  approx_quantiles(
    BYTESOTHER / 1024, 1000
  )[offset(PERCENTILE * 10)] AS OTHER_KBYTES,
  approx_quantiles(
    calculate_emissions(BYTESOTHER, KW_PER_GB, GLOBAL_GRID_INTENSITY), 1000
  )[offset(PERCENTILE * 10)] AS OTHER_EMISSIONS,
  -- HTML document
  approx_quantiles(
    BYTESHTMLDOC / 1024, 1000
  )[offset(PERCENTILE * 10)] AS HTML_DOC_KBYTES,
  approx_quantiles(
    calculate_emissions(BYTESHTMLDOC, KW_PER_GB, GLOBAL_GRID_INTENSITY),
    1000
  )[offset(PERCENTILE * 10)] AS HTML_DOC_EMISSIONS,
  -- Font resources
  approx_quantiles(
    BYTESFONT / 1024, 1000
  )[offset(PERCENTILE * 10)] AS FONT_KBYTES,
  approx_quantiles(
    calculate_emissions(BYTESFONT, KW_PER_GB, GLOBAL_GRID_INTENSITY), 1000
  )[offset(PERCENTILE * 10)] AS FONT_EMISSIONS
FROM
  PAGE_DATA,
  unnest([10, 25, 50, 75, 90, 100]) AS PERCENTILE
GROUP BY
  PERCENTILE,
  CLIENT
ORDER BY
  CLIENT,
  PERCENTILE
