#standardSQL
# Subresource integrity: hash function usage
SELECT
  client,
  hash_function,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_sri_elements,
  COUNT(0) AS freq,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload, '$._security'), '$.sri-integrity') AS sris
  FROM
    `httparchive.pages.2020_08_01_*`
),
  UNNEST(sris) AS sri,
  UNNEST(REGEXP_EXTRACT_ALL(JSON_EXTRACT_SCALAR(sri, '$.integrity'), r'(sha[^-]+)-')) AS hash_function
WHERE
  sri IS NOT NULL
GROUP BY
  client,
  hash_function
ORDER BY
  client,
  pct DESC
