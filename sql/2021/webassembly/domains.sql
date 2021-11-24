SELECT
  *,
  domains_using_wasm / all_domains AS domains_using_wasm_pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(DISTINCT NET.REG_DOMAIN(url)) AS all_domains
  FROM
    `httparchive.summary_pages.2021_09_01_*`
  GROUP BY
    client
)
JOIN (
  SELECT
    client,
    COUNT(DISTINCT NET.REG_DOMAIN(page)) AS domains_using_wasm
  FROM
    `httparchive.almanac.wasm_stats`
  WHERE
    date = '2021-09-01'
  GROUP BY
    client
)
USING (client)
ORDER BY
  client
