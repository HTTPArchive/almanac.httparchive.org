WITH totals AS (
  SELECT
    date,
    client,
    is_root_page,
    COUNT(0) AS num_pages
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'
  GROUP BY
    date,
    client,
    is_root_page
)

SELECT
  date,
  client,
  is_root_page,
  COUNTIF(INT64(custom_metrics.other.almanac.scripts.total) > 0) AS pages_using_js,
  num_pages,
  COUNTIF(INT64(custom_metrics.other.almanac.scripts.total) > 0) / num_pages AS pct_pages_using_js
FROM
  `httparchive.crawl.pages`
INNER JOIN
  totals
USING (date, client, is_root_page)
WHERE
  date = '2025-07-01'
GROUP BY
  date,
  client,
  is_root_page,
  num_pages
ORDER BY
  date,
  client,
  is_root_page
