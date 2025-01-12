#standardSQL
# Subresource integrity: hash function usage
WITH totals AS (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_sri_elements
  FROM
    `httparchive.pages.2021_07_01_*`,
    UNNEST(JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload, '$._security'), '$.sri-integrity')) AS sri
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
    _TABLE_SUFFIX AS client,
    JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload, '$._security'), '$.sri-integrity') AS sris
  FROM
    `httparchive.pages.2021_07_01_*`
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
