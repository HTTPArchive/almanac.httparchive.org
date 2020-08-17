#standardSQL
# hreflang implementation values

CREATE TEMPORARY FUNCTION getHreflangValues(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
  try {
    var $ = JSON.parse(payload);
    var almanac = JSON.parse($._almanac);

   if (almanac['link-nodes'] && almanac['link-nodes'].length > 0) {
     return almanac['link-nodes'].filter(e => e.hreflang).map(e => e.hreflang);    
   }
   return [];  
  } catch (e) {
    return [];
  }
''';

SELECT
  client,
  NORMALIZE_AND_CASEFOLD(TRIM(hreflang)) AS hreflang,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    getHreflangValues(payload) AS hreflang_values 
  FROM
    `httparchive.almanac.pages_*`
    ),
    UNNEST(hreflang_values) AS hreflang
GROUP BY client, hreflang
ORDER BY
  freq / total DESC
LIMIT 10000