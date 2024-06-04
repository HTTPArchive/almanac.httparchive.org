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
),

crux_inp AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    httparchive.core_web_vitals.GET_CRUX_INP(payload) AS inp
  FROM
    `httparchive.pages.2022_06_01_*`
),

combined AS (
  SELECT
    client,
    long_tasks,
    inp
  FROM
    per_page
  JOIN
    crux_inp
  USING (client, page)
),

meta AS (
  SELECT
    *,
    COUNT(0) OVER (PARTITION BY client) AS n,
    ROW_NUMBER() OVER (PARTITION BY client ORDER BY inp) AS row
  FROM
    combined
  WHERE
    inp IS NOT NULL
)

SELECT
  client,
  long_tasks,
  inp
FROM
  meta
WHERE
  MOD(row, CAST(FLOOR(n / 1000) AS INT64)) = 0
