CREATE TEMP FUNCTION HAS_NO_STORE_DIRECTIVE(cache_control STRING) RETURNS BOOL AS (
  REGEXP_CONTAINS(cache_control, r'(?i)\bno-store\b')
);

WITH requests AS (
  SELECT
    client,
    LOGICAL_OR(HAS_NO_STORE_DIRECTIVE(JSON_VALUE(payload, '$._cacheControl'))) AS includes_ccns
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2023-10-01' AND
    is_main_document
  GROUP BY
    client,
    page
)

SELECT
  client,
  COUNTIF(includes_ccns) AS pages,
  COUNT(0) AS total,
  COUNTIF(includes_ccns) / COUNT(0) AS pct
FROM
  requests
GROUP BY
  client
ORDER BY
  client
