#standardSQL
#OpenType axis(??NoResult)
SELECT
  client,
  name,
  axisValue,
  axisTag,
  axisSize,
  COUNT(DISTINCT page) AS freq,
  total_page,
  COUNT(DISTINCT page) * 100 / total_page AS pct
FROM
  `httparchive.almanac.requests`,
  UNNEST(REGEXP_EXTRACT_ALL(JSON_EXTRACT(payload,
        '$._font_details.name'), '(?i)(name)')) AS name,
  UNNEST(REGEXP_EXTRACT_ALL(JSON_EXTRACT(payload,
        '$._font_details.table_sizes'), '(?i)(gvar)')) AS axisValue,
  UNNEST(REGEXP_EXTRACT_ALL(JSON_EXTRACT(payload,
        '$._font_details.table_sizes.fvar'), '(?i)(axisTag)')) AS axisTag,
  UNNEST(REGEXP_EXTRACT_ALL(JSON_EXTRACT(payload,
        '$._font_details.table_sizes.fvar'), '(?i)(axis.size)')) AS axisSize  
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_page
  FROM
    `httparchive.summary_pages.2020_08_01_*`
  GROUP BY
    _TABLE_SUFFIX)
USING
  (client)      
WHERE
  type = 'font'
  AND date='2020-08-01'
GROUP BY
  client,
  name,
  axisValue,
  axisTag,
  axisSize,
  total_page
ORDER BY
  freq DESC
