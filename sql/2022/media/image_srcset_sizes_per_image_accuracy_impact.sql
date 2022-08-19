CREATE TEMPORARY FUNCTION getTotalEstimatedWastedLoadedPixels(payload STRING)
RETURNS totalWastedLoadedPixels INT64
LANGUAGE js AS '''
try {

  var $ = JSON.parse(payload);
  var responsiveImages = JSON.parse($._responsive_images);
  responsiveImages = responsiveImages['responsive-images'];

  return responsiveImages.reduce( ( acc, cv ) => {
    if ( cv.actualSizesEstimatedWastedLoadedPixels > 0 ) {
      acc += actualSizesEstimatedWastedLoadedPixels;
    }
    return acc;
  }, 0 );

} catch (e) {
  return 0;
}
''';

CREATE TEMPORARY FUNCTION getTotalEstimatedWastedLoadedBytes(payload STRING)
RETURNS totalEstimatedWastedLoadedBytes FLOAT64
LANGUAGE js AS '''
try {

  var $ = JSON.parse(payload);
  var responsiveImages = JSON.parse($._responsive_images);
  responsiveImages = responsiveImages['responsive-images'];

  return responsiveImages.reduce( ( acc, cv ) => {
    if ( cv.actualSizesEstimatedWastedLoadedBytes > 0 ) {
      acc += actualSizesEstimatedWastedLoadedBytes;
    }
    return acc;
  }, 0 );

} catch (e) {
  return 0;
}
''';

SELECT
  percentile,
  client,
  APPROX_QUANTILES(totalEstimatedWastedLoadedPixels, 1000)[OFFSET(percentile * 10)] AS totalEstimatedWastedLoadedPixels,
  APPROX_QUANTILES(totalEstimatedWastedLoadedBytes, 1000)[OFFSET(percentile * 10)] AS totalEstimatedWastedLoadedBytes
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    getTotalEstimatedWastedLoadedPixels(payload) as totalEstimatedWastedLoadedPixels,
    getTotalEstimatedWastedLoadedBytes(payload) as totalEstimatedWastedLoadedBytes
  FROM
    `httparchive.pages.2022_06_01_*`,
    UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
