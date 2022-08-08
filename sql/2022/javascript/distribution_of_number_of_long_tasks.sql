#standardSQL
# Distribution of number of long tasks per page

CREATE TEMPORARY FUNCTION getLongTasks(payload STRING)
RETURNS ARRAY<INT64>
LANGUAGE js AS '''
try {
  const $ = JSON.parse(payload);
  const longTasks = $._longTasks;

  if (longTasks) {
    return longTasks.map(n => n[1] - n[0]);
  }

  return [];

} catch (e) {
  return [];
}
''';

WITH long_tasks_pages AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    _longTasks AS long_tasks
  FROM
    `httparchive.pages.2022_06_01_*`,
    UNNEST(getLongTasks(payload)) AS _longTasks
),

long_tasks_by_page AS (
  SELECT
    client,
    url AS page,
    COUNT(0) AS long_tasks
  FROM
    long_tasks_pages
  GROUP BY
    client,
    url
)

SELECT
  client,
  percentile,
  APPROX_QUANTILES(IF(long_tasks IS NOT NULL, long_tasks, 0), 1000)[OFFSET(percentile * 10)] AS number_of_long_tasks_per_page
FROM
  long_tasks_by_page,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  client,
  percentile
ORDER BY
  client,
  percentile
