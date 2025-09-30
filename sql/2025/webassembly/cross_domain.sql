# Query for wasm cross origin
# The % of wasm files requested cross-origin.

SELECT
  client,
  COUNTIF(NET.REG_DOMAIN(page) != NET.REG_DOMAIN(url)) / COUNT(0) AS cross_origin_percentage
FROM
  `httparchive.crawl.requests`
WHERE
  date = '2025-07-01' AND
  type = 'wasm'
GROUP BY
  client
ORDER BY
  client
