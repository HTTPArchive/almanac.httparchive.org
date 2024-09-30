#standardSQL
  # Section: Malpractices on the web
  # Question: How many sites used cryptominers over time?
  # Note: The usage is very low, so maybe we want to drop this query. Also unclear which starting date we want
SELECT
  DATE_TRUNC(date, MONTH) AS month,
  client,
  COUNT(DISTINCT
    IF(category = 'Cryptominers', page, NULL)) AS freq,
  COUNT(DISTINCT page) AS total_pages,
  COUNT(DISTINCT
    IF(category = 'Cryptominers', page, NULL)) / COUNT(DISTINCT page) AS pct
FROM
  `httparchive.all.pages`,
  UNNEST(technologies) AS t,
  UNNEST(t.categories) AS category
WHERE
  date >= '2022-05-01' AND
  is_root_page
GROUP BY
  date,
  client
ORDER BY
  client,
  month,
  pct DESC
