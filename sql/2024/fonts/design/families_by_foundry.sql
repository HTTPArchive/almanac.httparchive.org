-- Section: Design
-- Question: Which families are used within each foundry?

SELECT
  client,
  JSON_EXTRACT_SCALAR(payload, '$._font_details.OS2.achVendID') AS foundry,
  JSON_EXTRACT_SCALAR(payload, '$._font_details.names[1]') AS family,
  COUNT(0) AS count,
  SUM(COUNT(0)) OVER(PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER(PARTITION BY client) AS proportion
FROM
  `httparchive.all.requests`
WHERE
  date = '2024-06-01' AND
  type = 'font'
GROUP BY
  client,
  foundry,
  family
ORDER BY
  proportion DESC
