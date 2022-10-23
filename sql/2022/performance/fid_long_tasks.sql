WITH long_tasks AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    CAST(JSON_QUERY(item, '$.duration') AS FLOAT64) AS long_task_duration
  FROM
    `lighthouse.2022_06_01_*`,
    UNNEST(JSON_QUERY_ARRAY(report, '$.audits.long-tasks.details.items')) AS item
),

per_page AS (
  SELECT
    client,
    page,
    SUM(long_task_duration) AS long_tasks
  FROM
    long_tasks
  GROUP BY
    client,
    page
)

SELECT
  percentile,
  client,
  APPROX_QUANTILES(long_tasks, 1000)[OFFSET(percentile * 10)] AS long_tasks
FROM
  per_page,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
