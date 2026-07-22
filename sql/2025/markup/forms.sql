WITH forms AS (
  SELECT
    client,
    page,
    IFNULL(LAX_INT64(custom_metrics.element_count.form), 0) AS forms_count
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'
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
