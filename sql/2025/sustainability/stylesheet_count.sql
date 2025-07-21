#standardSQL
# Breakdown of inline vs external scripts
WITH stylesheet_data AS (
  SELECT
    client,
    page,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT(JSON_EXTRACT_SCALAR(payload, '$._javascript'), '$.document'), '$.stylesheets') AS INT64) AS external_stylesheets,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT(JSON_EXTRACT_SCALAR(payload, '$._javascript'), '$.document'), '$.inlineStyles') AS INT64) AS inline_stylesheets,
    SAFE_DIVIDE(
      CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT(JSON_EXTRACT_SCALAR(payload, '$._javascript'), '$.document'), '$.inlineStyles') AS INT64),
      CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT(JSON_EXTRACT_SCALAR(payload, '$._javascript'), '$.document'), '$.stylesheets') AS INT64) +
      CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT(JSON_EXTRACT_SCALAR(payload, '$._javascript'), '$.document'), '$.inlineStyles') AS INT64)
    ) AS pct_inline_stylesheets,
    SAFE_DIVIDE(
      CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT(JSON_EXTRACT_SCALAR(payload, '$._javascript'), '$.document'), '$.stylesheets') AS INT64),
      CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT(JSON_EXTRACT_SCALAR(payload, '$._javascript'), '$.document'), '$.stylesheets') AS INT64) +
      CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT(JSON_EXTRACT_SCALAR(payload, '$._javascript'), '$.document'), '$.inlineStyles') AS INT64)
    ) AS pct_external_stylesheets
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-06-01'
    AND
    is_root_page = TRUE AND
    JSON_EXTRACT_SCALAR(JSON_EXTRACT(JSON_EXTRACT_SCALAR(payload, '$._javascript'), '$.document'), '$.stylesheets') IS NOT NULL
)

SELECT
  client,
  COUNT(DISTINCT page) AS pages_analyzed,
  SUM(external_stylesheets) AS external_stylesheets,
  SUM(inline_stylesheets) AS inline_stylesheets,
  SAFE_DIVIDE(SUM(inline_stylesheets), SUM(inline_stylesheets + external_stylesheets)) AS pct_inline_stylesheets,
  SAFE_DIVIDE(SUM(external_stylesheets), SUM(inline_stylesheets + external_stylesheets)) AS pct_external_stylesheets,
  APPROX_QUANTILES(SAFE_DIVIDE(inline_stylesheets, inline_stylesheets + external_stylesheets), 1000) [OFFSET(500)] AS median_inline_stylesheets,
  APPROX_QUANTILES(SAFE_DIVIDE(external_stylesheets, inline_stylesheets + external_stylesheets), 1000) [OFFSET(500)] AS median_external_stylesheets
FROM
  stylesheet_data
GROUP BY
  client
ORDER BY
  client;
