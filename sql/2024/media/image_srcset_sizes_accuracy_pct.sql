#standardSQL
# How accurate are srcset and sizes attributes, and what is the impact of sizes innacuracies on srcset selection?
# image_srcset_sizes_accuracy_pct.sql

CREATE TEMPORARY FUNCTION getSrcsetSizesAccuracy(payload STRING)
RETURNS ARRAY<STRUCT<srcsetHasWDescriptors BOOL, sizesAbsoluteError INT64, sizesRelativeError FLOAT64, wDescriptorAbsoluteError INT64, actualSizesEstimatedWastedLoadedPixels INT64>>
LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var responsiveImages = JSON.parse($._responsive_images);
  responsiveImages = responsiveImages['responsive-images'];

  return responsiveImages.map(({srcsetHasWDescriptors, sizesAbsoluteError, sizesRelativeError, wDescriptorAbsoluteError, actualSizesEstimatedWastedLoadedPixels}) => ({
    srcsetHasWDescriptors,
    sizesAbsoluteError,
    sizesRelativeError,
    wDescriptorAbsoluteError,
    actualSizesEstimatedWastedLoadedPixels
  }));
} catch (e) {
  return [];
}
''';

SELECT
  _TABLE_SUFFIX AS client,
  COUNTIF(image.sizesRelativeError > 0.05) AS some_sizes_error,
  COUNTIF(image.wDescriptorAbsoluteError > 0) AS any_w_descriptor_error,
  COUNTIF(image.actualSizesEstimatedWastedLoadedPixels > 0) AS sizes_error_impacted_srcset_selection,
  COUNT(0) AS total_images,
  COUNTIF(image.srcsetHasWDescriptors) AS total_images_with_w_descriptors,
  COUNTIF(image.sizesRelativeError > 0.05) / COUNTIF(image.srcsetHasWDescriptors) AS pct_some_sizes_error,
  COUNTIF(image.wDescriptorAbsoluteError > 0) / COUNTIF(image.srcsetHasWDescriptors) AS pct_any_w_descriptor_error,
  COUNTIF(image.actualSizesEstimatedWastedLoadedPixels > 0) / COUNTIF(image.srcsetHasWDescriptors) AS pct_sizes_error_impacted_srcset_selection
FROM
  `httparchive.pages.2024_06_01_*`,
  UNNEST(getSrcsetSizesAccuracy(payload)) AS image
GROUP BY
  client
