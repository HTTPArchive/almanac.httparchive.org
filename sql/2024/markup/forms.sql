WITH forms AS (
  SELECT
    client,
    page,
    CAST(IFNULL(JSON_VALUE(JSON_EXTRACT(custom_metrics, '$.element_count'), '$.form'), '0') AS INT64) AS forms_count
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01'
)

SELECT
  client,
  forms_count,
  COUNT(0) AS pages,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct_pages
FROM
  forms
GROUP BY
  client,
  forms_count
ORDER BY
  forms_count ASC
