SELECT
  client,
  JSON_EXTRACT_SCALAR(payload, '$._font_details.OS2.achVendID') AS vendor,
  JSON_EXTRACT_SCALAR(payload, '$._font_details.names[1]') AS family,
  COUNT(0) AS total,
  COUNT(0) * 1.0 / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  `httparchive.almanac.requests`
WHERE
  date = '2022-06-01' AND
  type = 'font'
GROUP BY
  client,
  vendor,
  family
QUALIFY
  pct > 0.001
ORDER BY pct DESC
