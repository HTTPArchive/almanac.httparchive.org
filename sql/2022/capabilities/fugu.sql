#standardSQL
CREATE TEMP FUNCTION getFuguAPIs(data STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS '''
const $ = JSON.parse(data);
return Object.keys($);
''';

SELECT
  _TABLE_SUFFIX AS client,
  fuguAPI,
  COUNT(DISTINCT url) AS pages,
  total,
  COUNT(DISTINCT url) / total AS pct,
  ARRAY_TO_STRING(ARRAY_AGG(DISTINCT url LIMIT 50), ' ') AS sample_urls
FROM
  `httparchive.pages.2022_06_01_*`
JOIN (
  SELECT
    _TABLE_SUFFIX,
    COUNT(0) AS total
  FROM
    `httparchive.pages.2022_06_01_*`
  GROUP BY
    _TABLE_SUFFIX
)
USING (_TABLE_SUFFIX),
  UNNEST(getFuguAPIs(JSON_QUERY(payload, '$."_fugu-apis"'))) AS fuguAPI
WHERE
  JSON_QUERY(payload, '$."_fugu-apis"') != '[]'
GROUP BY
  fuguAPI,
  client,
  total
HAVING
  COUNT(DISTINCT url) >= 10
ORDER BY
  pct DESC,
  client;
