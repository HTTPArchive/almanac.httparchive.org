#standardSQL
# Section: Content Inclusion - Subresource Integrity
# Question: Which are the most popular hosts for which SRI is used on script tags?
WITH totals AS (
  SELECT
    client,
    COUNT(0) AS total_sri_scripts
  FROM
    `httparchive.all.pages`,
    UNNEST(JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload, '$._security'), '$.sri-integrity')) AS sri
  WHERE
    date = '2024-06-01' AND
    is_root_page AND
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
    client,
    page AS url,
    JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload, '$._security'), '$.sri-integrity') AS sris
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01' AND
    is_root_page
),
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
LIMIT 1000
