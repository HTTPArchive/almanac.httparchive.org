#standardSQL
# th and td stats. Scope and headers usage
SELECT
  client,
  COUNT(0) AS total_sites,
  COUNTIF(total_tables > 0) AS sites_with_table,
  COUNTIF(total_th > 0) AS sites_with_th,
  COUNTIF(total_td > 0) AS sites_with_td,
  COUNTIF(total_th_with_scope > 0) AS sites_with_th_scope,
  COUNTIF(total_td_with_headers > 0) AS sites_with_td_headers,

  COUNTIF(total_tables > 0) / COUNT(0) AS pct_sites_with_table,
  COUNTIF(total_th > 0) / COUNT(0) AS pct_sites_with_th,
  COUNTIF(total_td > 0) / COUNT(0) AS pct_sites_with_td,

  COUNTIF(total_th_with_scope > 0) / COUNTIF(total_th > 0) AS pct_th_sites_with_scope,
  COUNTIF(total_td_with_headers > 0) / COUNTIF(total_td > 0) AS pct_td_sites_with_headers
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._a11y'), '$.tables.total') AS INT64) AS total_tables,

    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._a11y'), '$.th_with_scope_attribute.total_th') AS INT64) AS total_th,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._a11y'), '$.th_with_scope_attribute.total_with_scope') AS INT64) AS total_th_with_scope,

    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._a11y'), '$.td_with_headers_attribute.total_tds') AS INT64) AS total_td,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._a11y'), '$.td_with_headers_attribute.total_with_headers') AS INT64) AS total_td_with_headers
  FROM
    `httparchive.pages.2021_07_01_*`
)
GROUP BY
  client
