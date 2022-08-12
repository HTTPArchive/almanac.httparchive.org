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
),

percentiles AS (
  SELECT
    client,
    APPROX_QUANTILES(numberOfImages, 1000) AS numberOfImagesPercentiles
  FROM
    numImgs
  GROUP BY
    client
)

SELECT
  client,
  percentile,
  numberOfImagesPercentiles[OFFSET(percentile * 10)] AS numberOfImages
FROM
  percentiles,
  UNNEST([0, 10, 25, 50, 75, 90, 100]) AS percentile
