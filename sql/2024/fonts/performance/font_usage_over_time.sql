SELECT
  client,
  date,
  COUNTIF(type = 'font') AS count,
  COUNT(0) AS total,
  COUNTIF(type = 'font') / COUNT(0) AS proportion
FROM
  `httparchive.all.requests`
WHERE
  date IS NOT NULL
GROUP BY
  client,
  date
ORDER BY
  client,
  date DESC
