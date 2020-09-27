#standardSQL
# Duplicate ID occurrences
SELECT
  client,
  COUNT(0) AS total_sites,
  COUNTIF(total_duplicate_ids > 0) AS total_with_duplicate_ids,

  COUNTIF(total_duplicate_ids > 0) / COUNT(0) AS pct_with_duplicate_ids,

  SUM(total_duplicate_ids) AS total_duplicate_ids,
  APPROX_QUANTILES(total_duplicate_ids, 100)[SAFE_ORDINAL(50)] AS median_duplicate_ids,
  MAX(total_duplicate_ids) AS max_duplicate_ids,
  AVG(total_duplicate_ids) AS avg_duplicate_ids
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._markup'), '$.ids.duplicate_ids_total') AS INT64) AS total_duplicate_ids
  FROM
    `httparchive.pages.2020_08_01_*`
)
GROUP BY
  client
