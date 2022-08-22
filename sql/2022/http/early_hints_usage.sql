#standardSQL

# Distribution of number of early hints resources

SELECT
  client,
  COUNT(DISTINCT page) AS num_pages,
  COUNTIF(JSON_EXTRACT(payload, '$._early_hint_headers') IS NOT NULL) AS early_hints,
  COUNTIF(JSON_EXTRACT(payload, '$._early_hint_headers') IS NOT NULL) / COUNT(DISTINCT page) AS early_hints_pct
FROM
  `httparchive.almanac.requests`
WHERE
  date = '2022-06-01' AND
  firstHtml
GROUP BY
  client
