#standardSQL
# Breakdown of inline vs external scripts
WITH script_data AS (
  SELECT
    client,
    page,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT(JSON_EXTRACT_SCALAR(payload, '$._javascript'), '$.script_tags'), '$.total') AS INT64) AS total_scripts,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT(JSON_EXTRACT_SCALAR(payload, '$._javascript'), '$.script_tags'), '$.inline') AS INT64) AS inline_scripts,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT(JSON_EXTRACT_SCALAR(payload, '$._javascript'), '$.script_tags'), '$.src') AS INT64) AS external_scripts,
    SAFE_DIVIDE(CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT(JSON_EXTRACT_SCALAR(payload, '$._javascript'), '$.script_tags'), '$.inline') AS INT64),
      CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT(JSON_EXTRACT_SCALAR(payload, '$._javascript'), '$.script_tags'), '$.total') AS INT64)) AS pct_inline_script,
    SAFE_DIVIDE(CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT(JSON_EXTRACT_SCALAR(payload, '$._javascript'), '$.script_tags'), '$.src') AS INT64),
      CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT(JSON_EXTRACT_SCALAR(payload, '$._javascript'), '$.script_tags'), '$.total') AS INT64)) AS pct_external_script
  FROM
    `httparchive.all.pages` TABLESAMPLE SYSTEM (0.01 PERCENT)
  WHERE
    date = '2024-06-01' AND
    JSON_EXTRACT_SCALAR(JSON_EXTRACT(JSON_EXTRACT_SCALAR(payload, '$._javascript'), '$.script_tags'), '$.total') IS NOT NULL
)

SELECT
  client,
  COUNT(DISTINCT page) AS pages_analyzed,
  SUM(total_scripts) AS total_scripts,
  SUM(inline_scripts) AS inline_scripts,
  SUM(external_scripts) AS external_scripts,
  SAFE_DIVIDE(SUM(external_scripts), SUM(total_scripts)) AS pct_external_script,
  SAFE_DIVIDE(SUM(inline_scripts), SUM(total_scripts)) AS pct_inline_script,
  APPROX_QUANTILES(SAFE_DIVIDE(external_scripts, total_scripts), 1000)[OFFSET(500)] AS median_external,
  APPROX_QUANTILES(SAFE_DIVIDE(inline_scripts, total_scripts), 1000)[OFFSET(500)] AS median_inline
FROM
  script_data
GROUP BY
  client
ORDER BY
  client;
