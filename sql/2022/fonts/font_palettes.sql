SELECT
  client,
  SAFE_CAST(JSON_EXTRACT_SCALAR(payload, '$._font_details.color.numPalettes') AS INT64) AS entries,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER(PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  `httparchive.almanac.requests`
WHERE
  date = '2022-06-01' AND
  type = 'font'
GROUP BY
  client,
  entries
ORDER BY
  client,
  pct DESC
