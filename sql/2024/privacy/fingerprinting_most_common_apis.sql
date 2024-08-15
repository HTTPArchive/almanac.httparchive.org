CREATE TEMP FUNCTION getFingerprintingTypes(input STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS """return Object.keys(JSON.parse(input).privacy?.fingerprinting?.counts || {})""";

WITH pages AS (
  SELECT client, page, fingerprinting_type FROM `httparchive.all.pages`, -- TABLESAMPLE SYSTEM (0.001 PERCENT)
    unnest(getFingerprintingTypes(custom_metrics)) AS fingerprinting_type WHERE date = '2024-06-01'
)
SELECT client, fingerprinting_type, count(DISTINCT page) AS page_count FROM pages GROUP BY client, fingerprinting_type ORDER BY page_count DESC
