-- Section: Performance
-- Question: What is the font usage over time?
-- Normalization: Pages

SELECT
  date,
  client,
  COUNT(DISTINCT IF(type = 'font', page, NULL)) AS count,
  COUNT(DISTINCT page) AS total,
  COUNT(DISTINCT IF(type = 'font', page, NULL)) / COUNT(DISTINCT page) AS proportion
FROM
  `httparchive.all.requests`
WHERE
  date IS NOT NULL AND
  is_root_page
GROUP BY
  client,
  date
ORDER BY
  date,
  client
