WITH long_tasks AS (
  SELECT
    client,
    page,
    ANY_VALUE(httparchive.core_web_vitals.GET_CRUX_INP(summary)) AS inp,
    SUM(CAST(JSON_VALUE(item.duration) AS FLOAT64)) AS long_tasks
  FROM
    `httparchive.crawl.pages`,
    UNNEST(JSON_QUERY_ARRAY(lighthouse.audits.`long-tasks`.details.items)) AS item
  WHERE
    date = '2025-07-01' AND
    is_root_page
  GROUP BY
    client,
    page
),

meta AS (
  SELECT
    *,
    COUNT(0) OVER (PARTITION BY client) AS n,
    ROW_NUMBER() OVER (PARTITION BY client ORDER BY inp) AS row
  FROM
    long_tasks
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
ORDER BY
  client,
  long_tasks
