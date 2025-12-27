#standardSQL
# Section: Content Inclusion - Subresource Integrity
# Question: Wich are the most common SRI hash functions used?
WITH totals AS (
  SELECT
    client,
    COUNT(0) AS total_sri_elements
  FROM
    `httparchive.crawl.pages`,
    UNNEST(JSON_EXTRACT_ARRAY(custom_metrics.security, '$.sri-integrity')) AS sri
  WHERE
    date = '2025-07-01' AND
    is_root_page
  GROUP BY
    client
)

SELECT
  client,
  hash_function,
  total_sri_elements,
  COUNT(0) AS freq,
  COUNT(0) / total_sri_elements AS pct
FROM (
  SELECT
    client,
    JSON_EXTRACT_ARRAY(custom_metrics.security, '$.sri-integrity') AS sris
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01' AND
    is_root_page
),
  UNNEST(sris) AS sri,
  UNNEST(REGEXP_EXTRACT_ALL(JSON_EXTRACT_SCALAR(sri, '$.integrity'), r'(sha[^-]+)-')) AS hash_function
JOIN totals USING (client)
WHERE
  sri IS NOT NULL
GROUP BY
  client,
  total_sri_elements,
  hash_function
ORDER BY
  client,
  pct DESC
