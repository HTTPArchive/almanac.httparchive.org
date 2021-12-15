CREATE TEMPORARY FUNCTION numberOfImages(images_string STRING)
RETURNS INT64
LANGUAGE js AS '''
try {
  return JSON.parse(images_string).filter( i => parseInt(i.approximateResourceWidth) > 1 && parseInt(i.approximateResourceWidth) > 1 ).length;
} catch {
  return 0;
}
''';

WITH numImgs AS (
  SELECT
    _TABLE_SUFFIX AS client,
    numberOfImages( JSON_QUERY( JSON_VALUE( payload, '$._responsive_images' ), '$.responsive-images' ) ) AS numberOfImages
  FROM
    `httparchive.pages.2021_07_01_*`
)

SELECT
  client,
  COUNTIF( numberOfImages > 0 ) AS atLeastOneCount,
  COUNT(0) AS total,
  SAFE_DIVIDE( COUNTIF( numberOfImages > 0 ), COUNT(0) ) AS atLeastOnePct
FROM
  numImgs
GROUP BY
  client
