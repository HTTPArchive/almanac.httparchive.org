#standardSQL
# percientile data per device
# See related: sql/2019/03_Markup/03_06.sql
CREATE TEMPORARY FUNCTION countElements(elementsJsonString STRING)
RETURNS INT64 LANGUAGE js AS '''
try {
  var elements = JSON.parse(elementsJsonString);
  if (Array.isArray(elements) || typeof elements != 'object') return null;
  return Object.values(elements).reduce((total, freq) => total + (parseInt(freq, 10) || 0), 0);
} catch (e) {
  return null;
}
''';

SELECT
  percentile,
  client,
  COUNT(DISTINCT url) AS pages,

  # Elements per page
  APPROX_QUANTILES(elements, 1000)[OFFSET(percentile * 10)] AS elements_count,
  CAST(ROUND(AVG(elements)) AS INT64) AS elements_avg, # not sure what value this is? average elements per page? same for all device rows
  MIN(elements) AS elements_min, # y-axis min, same for all device rows
  MAX(elements) AS elements_max # y-axis max, same for all device rows
FROM (
  SELECT
    client,
    url,
    countElements(elementsJsonString) AS elements
  FROM
  ( 
    SELECT 
      _TABLE_SUFFIX AS client,
      url,
      payload,
      #JSON_EXTRACT_SCALAR(payload, '$._almanac') AS almanac
      JSON_EXTRACT_SCALAR(payload, '$._element_count') AS elementsJsonString
    FROM
    `httparchive.almanac.pages_*`
  )
),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
