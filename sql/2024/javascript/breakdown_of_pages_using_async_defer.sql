#standardSQL
# Breakdown of scripts using Async, Defer, Module or NoModule attributes.  Also breakdown of inline vs external scripts
SELECT
  _TABLE_SUFFIX AS client,
  COUNTIF(CAST(JSON_EXTRACT(JSON_EXTRACT_SCALAR(payload, '$._javascript'), '$.script_tags.async') AS INT64) > 0) AS async,
  COUNTIF(CAST(JSON_EXTRACT(JSON_EXTRACT_SCALAR(payload, '$._javascript'), '$.script_tags.defer') AS INT64) > 0) AS defer,
  COUNTIF(CAST(JSON_EXTRACT(JSON_EXTRACT_SCALAR(payload, '$._javascript'), '$.script_tags.async_and_defer') AS INT64) > 0) AS async_and_defer,
  COUNTIF(CAST(JSON_EXTRACT(JSON_EXTRACT_SCALAR(payload, '$._javascript'), '$.script_tags.type_module') AS INT64) > 0) AS module,
  COUNTIF(CAST(JSON_EXTRACT(JSON_EXTRACT_SCALAR(payload, '$._javascript'), '$.script_tags.nomodule') AS INT64) > 0) AS nomodule,
  COUNTIF(CAST(JSON_EXTRACT(JSON_EXTRACT_SCALAR(payload, '$._javascript'), '$.script_tags.async') AS INT64) > 0) / COUNT(0) AS async_pct,
  COUNTIF(CAST(JSON_EXTRACT(JSON_EXTRACT_SCALAR(payload, '$._javascript'), '$.script_tags.defer') AS INT64) > 0) / COUNT(0) AS defer_pct,
  COUNTIF(CAST(JSON_EXTRACT(JSON_EXTRACT_SCALAR(payload, '$._javascript'), '$.script_tags.async_and_defer') AS INT64) > 0) / COUNT(0) AS async_and_defer_pct,
  COUNTIF(CAST(JSON_EXTRACT(JSON_EXTRACT_SCALAR(payload, '$._javascript'), '$.script_tags.type_module') AS INT64) > 0) / COUNT(0) AS module_pct,
  COUNTIF(CAST(JSON_EXTRACT(JSON_EXTRACT_SCALAR(payload, '$._javascript'), '$.script_tags.nomodule') AS INT64) > 0) / COUNT(0) AS nomodule_pct,
  COUNTIF(CAST(JSON_EXTRACT(JSON_EXTRACT_SCALAR(payload, '$._javascript'), '$.script_tags.async') AS INT64) = 0 AND CAST(JSON_EXTRACT(JSON_EXTRACT_SCALAR(payload, '$._javascript'), '$.script_tags.defer') AS INT64) = 0) AS neither,
  COUNTIF(CAST(JSON_EXTRACT(JSON_EXTRACT_SCALAR(payload, '$._javascript'), '$.script_tags.async') AS INT64) = 0 AND CAST(JSON_EXTRACT(JSON_EXTRACT_SCALAR(payload, '$._javascript'), '$.script_tags.defer') AS INT64) = 0) / COUNT(0) AS neither_pct
FROM
  `httparchive.all.pages`
WHERE
  date = '2024-06-01'

GROUP BY
  client
