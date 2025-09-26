# Query for the % of domains which use wasm

SELECT
  *,
  domains_using_wasm / all_domains AS domains_using_wasm_pct
FROM (
  SELECT
    client,
    COUNT(DISTINCT NET.REG_DOMAIN(page)) AS all_domains
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-06-01'
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
    date = '2025-06-01' AND type = 'wasm'
  GROUP BY
    client
)
USING (client)
ORDER BY
  client
