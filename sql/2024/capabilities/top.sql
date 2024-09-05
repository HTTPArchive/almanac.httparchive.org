#standardSQL
CREATE TEMP FUNCTION getFuguAPIs(data STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS '''
const $ = JSON.parse(data);
return Object.keys($);
''';

SELECT
  client,
  is_root_page,
  page,
  COUNT(DISTINCT fuguAPI) AS fuguAPIs
FROM
  `httparchive.all.pages`,
  UNNEST(getFuguAPIs(JSON_QUERY(custom_metrics, '$."fugu-apis"'))) AS fuguAPI
WHERE
  date = '2024-06-01' AND
  JSON_QUERY(custom_metrics, '$."fugu-apis"') != '[]'
GROUP BY
  client,
  is_root_page,
  page
HAVING
  COUNT(DISTINCT fuguAPI) >= 1
ORDER BY
  fuguAPIs DESC,
  page,
  client
LIMIT 200;
