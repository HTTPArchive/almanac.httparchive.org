#standardSQL
# Duplicate ID occurrences
SELECT
  client,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_sites,
  SUM(COUNTIF(total_duplicate_ids > 0)) OVER (PARTITION BY client) AS total_with_duplicate_ids,
  SUM(COUNTIF(total_duplicate_ids > 0)) OVER (PARTITION BY client) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct_with_duplicate_ids,
  MAX(total_duplicate_ids) AS max_duplicate_ids,

  percentile,
  APPROX_QUANTILES(total_duplicate_ids, 1000)[SAFE_ORDINAL(percentile * 10)] AS total_duplicate_ids
FROM (
    SELECT
      _TABLE_SUFFIX AS client,
      CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._markup'), '$.ids.duplicate_ids_total') AS INT64) AS total_duplicate_ids
    FROM
      `httparchive.pages.2020_08_01_*`
  ),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
