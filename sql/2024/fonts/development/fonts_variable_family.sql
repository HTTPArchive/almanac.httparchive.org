-- Section: Development
-- Question: Which color families are used?

CREATE TEMPORARY FUNCTION IS_VARIABLE(json STRING) AS (
  REGEXP_CONTAINS(
    JSON_EXTRACT(json, '$._font_details.table_sizes'),
    '(?i)gvar|CFF2'
  )
);

CREATE TEMPORARY FUNCTION NAME(value STRING) AS (
  IF(LENGTH(TRIM(value)) < 3, NULL, NULLIF(TRIM(value), ''))
);

SELECT
  client,
  NAME(JSON_EXTRACT_SCALAR(payload, '$._font_details.names[1]')) AS family,
  COUNT(DISTINCT url) AS count,
  SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS total,
  COUNT(DISTINCT url) / SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS proportion
FROM
  `httparchive.all.requests`
WHERE
  date = '2024-06-01' AND
  type = 'font' AND
  IS_VARIABLE(payload)
GROUP BY
  client,
  family
ORDER BY
  client,
  proportion DESC
