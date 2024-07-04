-- Section: Development
-- Question: How many palettes are there in color fonts?

SELECT
  client,
  SAFE_CAST(JSON_EXTRACT_SCALAR(payload, '$._font_details.color.numPalettes') AS INT64) AS entries,
  COUNT(0) AS count,
  SUM(COUNT(0)) OVER(PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS proportion
FROM
  `httparchive.all.requests`
WHERE
  date = '2024-06-01' AND
  type = 'font'
GROUP BY
  client,
  entries
ORDER BY
  client,
  proportion DESC
