#standardSQL
CREATE TEMP FUNCTION getFuguAPIs(data STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS '''
const $ = JSON.parse(data);
return Object.keys($);
''';

WITH fuguapis AS (
  SELECT
    date,
    client,
    root_page,
    page,
    fuguAPI
  FROM
    `httparchive.all.pages`,
    UNNEST(getFuguAPIs(JSON_QUERY(custom_metrics, '$."fugu-apis"'))) AS fuguAPI
  WHERE
    date = '2024-06-01' AND
    JSON_QUERY(custom_metrics, '$."fugu-apis"') != '[]'
),

totals AS (
  SELECT
    date,
    client,
    COUNT(0) AS total
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01' AND
    is_root_page
  GROUP BY
    date,
    client
)

SELECT
  client,
  fuguAPI,
  COUNT(DISTINCT root_page) AS pages,
  total,
  COUNT(DISTINCT root_page) / total AS pct,
  ARRAY_TO_STRING(ARRAY_AGG(DISTINCT page LIMIT 50), ' ') AS sample_urls
FROM
  fuguapis
JOIN
  totals
USING
  (client, date)
GROUP BY
  fuguAPI,
  client,
  total
HAVING
  COUNT(DISTINCT root_page) >= 10
ORDER BY
  pct DESC,
  client;
