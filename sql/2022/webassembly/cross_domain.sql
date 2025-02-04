# standardSQL
# The % of wasm files requested cross-origin.

SELECT
  client,
  COUNTIF(NET.REG_DOMAIN(page) != NET.REG_DOMAIN(url)) / COUNT(0) AS cross_origin_pct
FROM
  `httparchive.almanac.requests`
WHERE
  date = '2022-06-01' AND (mimeType = 'application/wasm' OR ext = 'wasm')
GROUP BY
  client
ORDER BY
  client
