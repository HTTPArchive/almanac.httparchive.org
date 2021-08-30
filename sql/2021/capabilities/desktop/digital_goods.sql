CREATE TEMP FUNCTION
  getFuguAPIs(DATA STRING)
  RETURNS ARRAY<STRING>
  LANGUAGE js AS '''
const $ = JSON.parse(data);
return Object.keys($);
''';
SELECT
  fuguAPI,
  url,
  payload
FROM
  `httparchive.pages.2021_07_01_desktop`,
  UNNEST(getFuguAPIs(JSON_QUERY(payload,
        '$."_fugu-apis"'))) AS fuguAPI
WHERE
  JSON_QUERY(payload,
    '$."_fugu-apis"') != "[]"
  AND fuguAPI = "Digital Goods"
GROUP BY
  fuguAPI,
  url,
  payload;
