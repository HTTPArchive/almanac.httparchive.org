#standardSQL
CREATE TEMP FUNCTION getFuguAPIs(data STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS '''
const $ = JSON.parse(data);
return Object.keys($);
''';

SELECT
  client,
  root_page,
  COUNT(DISTINCT fuguAPI) AS fuguAPIs,
  ARRAY_AGG(DISTINCT fuguAPI ORDER BY fuguAPI) AS fuguAPIsList
FROM
  `httparchive.crawl.pages`,
  UNNEST(getFuguAPIs(TO_JSON_STRING(custom_metrics.other ['fugu-apis']))) AS fuguAPI
WHERE
  TO_JSON_STRING(custom_metrics.other ['fugu-apis']) != '{}'
  AND TO_JSON_STRING(custom_metrics.other ['fugu-apis']) != 'null'
  AND custom_metrics.other ['fugu-apis'] IS NOT NULL
  AND date = '2025-07-01'
GROUP BY
  client,
  root_page
HAVING
  COUNT(DISTINCT fuguAPI) >= 1
ORDER BY
  fuguAPIs DESC,
  root_page,
  client
LIMIT 100;
