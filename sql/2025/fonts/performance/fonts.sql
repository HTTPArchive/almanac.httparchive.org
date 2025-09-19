-- Section: Performance
-- Question: What is the font usage over time?
-- Normalization: Pages

SELECT
  date,
  client,
  COUNT(DISTINCT IF(type = 'font', page, NULL)) AS count,
  COUNT(DISTINCT page) AS total,
  ROUND(COUNT(DISTINCT IF(type = 'font', page, NULL)) / COUNT(DISTINCT page), @precision) AS proportion
FROM
  `httparchive.crawl.requests`
WHERE
  date IS NOT NULL AND
  is_root_page
GROUP BY
  client,
  date
ORDER BY
  date,
  client
