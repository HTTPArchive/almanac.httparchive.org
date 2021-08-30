#standardSQL
CREATE TEMP FUNCTION getFuguAPIs(data STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS '''
const $ = JSON.parse(data);
return Object.keys($);
''';

SELECT
  _TABLE_SUFFIX AS client,
  url,
  COUNT(DISTINCT fuguAPI) AS fuguAPIs
FROM
  `httparchive.pages.2021_07_01_*`,
  UNNEST(getFuguAPIs(JSON_QUERY(payload, '$."_fugu-apis"'))) AS fuguAPI
WHERE
  JSON_QUERY(payload, '$."_fugu-apis"') != "[]"
GROUP BY
  client,
  url
HAVING
  COUNT(DISTINCT fuguAPI) >= 1
ORDER BY
  fuguAPIs DESC,
  url,
  client
LIMIT 100;
