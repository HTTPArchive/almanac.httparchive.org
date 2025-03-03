#standardSQL
# Percent of pages using parcel

SELECT
  client,
  COUNTIF('parcel' IN UNNEST(technologies.technology)) AS parcel_pages,
  COUNT(0) AS total_pages,
  COUNTIF('parcel' IN UNNEST(technologies.technology)) / COUNT(0) AS pct_parcel_pages
FROM
  `httparchive.crawl.pages`
WHERE
  date = '2024-06-01' AND
  is_root_page
GROUP BY
  client
ORDER BY
  client
