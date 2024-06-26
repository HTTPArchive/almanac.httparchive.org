# standardSQL
# The % of domains which use wasm.

SELECT
  *,
  domains_using_wasm / all_domains AS domains_using_wasm_pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(DISTINCT NET.REG_DOMAIN(url)) AS all_domains
  FROM
    `httparchive.summary_pages.2022_06_01_*`
  GROUP BY
    client
)
JOIN (
  SELECT
    client,
    COUNT(DISTINCT NET.REG_DOMAIN(page)) AS domains_using_wasm
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2022-06-01' AND (mimeType = 'application/wasm' OR ext = 'wasm')
  GROUP BY
    client
)
USING (client)
ORDER BY
  client
