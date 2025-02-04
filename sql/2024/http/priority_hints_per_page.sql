#standardSQL

# Number of resources with priority hints.

SELECT
  client,
  is_root_page,
  percentile,
  APPROX_QUANTILES(num_priority_hints, 1000)[OFFSET(percentile * 10)] AS num_percentiles
FROM (
  SELECT
    client,
    is_root_page,
    CAST(JSON_EXTRACT_SCALAR(custom_metrics, '$.almanac.priority-hints.total') AS INT64) AS num_priority_hints
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01'
),
  UNNEST([10, 25, 50, 75, 90, 95, 100]) AS percentile
GROUP BY
  client,
  is_root_page,
  percentile
ORDER BY
  client,
  is_root_page,
  percentile
