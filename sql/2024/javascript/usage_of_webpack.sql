#standardSQL
# Percent of pages using webpack grouped by rank

SELECT
  client,
  COUNTIF('Webpack' IN UNNEST(technologies.technology)) AS webpack_pages,
  COUNT(0) AS total_pages,
  COUNTIF('Webpack' IN UNNEST(technologies.technology)) / COUNT(0) AS pct_webpack_pages
FROM
  `httparchive.crawl.pages`
WHERE
  date = '2024-06-01' AND
  is_root_page
GROUP BY
  client
ORDER BY
  client
