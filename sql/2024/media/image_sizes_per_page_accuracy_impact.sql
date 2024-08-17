#standardSQL
# measure the impact of innacurate sizes attributes per page
# image_sizes_per_page_accuracy_impact.sql

CREATE TEMPORARY FUNCTION pageUsesWDescriptors(payload STRING)
RETURNS BOOL
LANGUAGE js AS '''
try {

  var $ = JSON.parse(payload);
  var responsiveImages = JSON.parse($._responsive_images);
  responsiveImages = responsiveImages['responsive-images'];

  return responsiveImages.reduce( ( acc, cv ) => {
    if ( cv.srcsetHasWDescriptors ) {
      acc = true;
    }
    return acc;
  }, false );

} catch (e) {
  return false;
}
''';

CREATE TEMPORARY FUNCTION getTotalEstimatedWastedLoadedPixels(payload STRING)
RETURNS INT64
LANGUAGE js AS '''
try {

  var $ = JSON.parse(payload);
  var responsiveImages = JSON.parse($._responsive_images);
  responsiveImages = responsiveImages['responsive-images'];

  return responsiveImages.reduce( ( acc, cv ) => {
    if ( cv.actualSizesEstimatedWastedLoadedPixels > 0 ) {
      acc += cv.actualSizesEstimatedWastedLoadedPixels;
    }
    return acc;
  }, 0 );

} catch (e) {
  return null;
}
''';

CREATE TEMPORARY FUNCTION getTotalEstimatedWastedLoadedBytes(payload STRING)
RETURNS FLOAT64
LANGUAGE js AS '''
try {

  var $ = JSON.parse(payload);
  var responsiveImages = JSON.parse($._responsive_images);
  responsiveImages = responsiveImages['responsive-images'];

  return responsiveImages.reduce( ( acc, cv ) => {
    if ( cv.actualSizesEstimatedWastedLoadedBytes > 0 ) {
      acc += cv.actualSizesEstimatedWastedLoadedBytes;
    }
    return acc;
  }, 0 );

} catch (e) {
  return null;
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
    getTotalEstimatedWastedLoadedPixels(payload) AS totalEstimatedWastedLoadedPixels,
    getTotalEstimatedWastedLoadedBytes(payload) AS totalEstimatedWastedLoadedBytes
  FROM
    `httparchive.pages.2024_06_01_*`
  WHERE
    pageUsesWDescriptors(payload) = TRUE
),
UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
