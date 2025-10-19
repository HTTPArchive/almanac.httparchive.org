# Query for the % of domains which use wasm

SELECT
  client,
  all_domains,
  domains_using_wasm,
  domains_using_wasm / all_domains AS percentage
FROM (
  SELECT
    client,
    COUNT(DISTINCT NET.REG_DOMAIN(page)) AS all_domains
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'
  GROUP BY
    client
)
JOIN (
  SELECT
    client,
    COUNT(DISTINCT NET.REG_DOMAIN(page)) AS domains_using_wasm
  FROM
    `httparchive.crawl.requests`
  WHERE
    date = '2025-07-01' AND
    type = 'wasm'
  GROUP BY
    client
)
USING (client)
ORDER BY
  client
