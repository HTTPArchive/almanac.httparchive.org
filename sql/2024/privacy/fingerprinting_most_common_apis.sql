CREATE TEMP FUNCTION getFingerprintingTypes(input STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS """
if (input) {
  try {
    return Object.keys(JSON.parse(input))
  } catch (e) {
    return []
  }
} else {
  return []
}
""";

WITH pages AS (
  SELECT client, page, fingerprinting_type, count(DISTINCT page) OVER (PARTITION BY client) AS total_pages FROM `httparchive.all.pages`, --TABLESAMPLE SYSTEM (0.01 PERCENT)
    unnest(getFingerprintingTypes(JSON_EXTRACT(custom_metrics, '$.privacy.fingerprinting.counts'))) AS fingerprinting_type WHERE date = '2024-06-01'
)
SELECT client, fingerprinting_type, count(DISTINCT page) AS page_count, count(DISTINCT page) / any_value(total_pages) AS pct_pages FROM pages GROUP BY client, fingerprinting_type ORDER BY page_count DESC
