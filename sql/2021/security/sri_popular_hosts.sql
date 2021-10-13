#standardSQL
# Subresource integrity: most popular hosts for which SRI is used on script tags
WITH totals AS (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_sri_scripts
  FROM
    `httparchive.pages.2021_07_01_*`,
    UNNEST( JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload, '$._security'), "$.sri-integrity")) AS sri
  WHERE
    sri IS NOT NULL AND
    JSON_EXTRACT_SCALAR(sri, '$.tagname') = 'script'
  GROUP BY
    client
)

SELECT
  client,
  NET.HOST(JSON_EXTRACT_SCALAR(sri, '$.src')) AS host,
  total_sri_scripts,
  COUNT(0) AS freq,
  COUNT(0) / total_sri_scripts AS pct,
  SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS total_urls,
  COUNT(DISTINCT url) AS freq_urls,
  COUNT(DISTINCT url) / SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS pct_urls
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload, '$._security'), "$.sri-integrity") AS sris
  FROM
    `httparchive.pages.2021_07_01_*`),
  UNNEST(sris) AS sri
JOIN totals USING (client)
WHERE
  sri IS NOT NULL AND
  JSON_EXTRACT_SCALAR(sri, '$.tagname') = 'script'
GROUP BY
  client,
  total_sri_scripts,
  host
ORDER BY
  pct DESC
