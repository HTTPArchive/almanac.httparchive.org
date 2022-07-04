WITH lcp_element_urls AS (
  SELECT
    _TABLE_SUFFIX AS client,
    JSON_EXTRACT(payload, '$._performance.lcp_resource.url') AS lcp_resource_url
  FROM
    `httparchive.pages.2022_06_01_*`
)

SELECT
  client,
  COUNTIF( lcp_resource_url IS NOT NULL ) as num_with_urls,
  COUNT(0) as num_total,
  COUNTIF( lcp_resource_url IS NOT NULL ) / COUNT(0) as pct_with_urls
FROM lcp_element_urls
GROUP BY client
