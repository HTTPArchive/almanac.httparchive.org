CREATE TEMPORARY FUNCTION getSizesAccuracy(payload STRING)
RETURNS ARRAY<STRUCT<sizesAbsoluteError INT64, sizesRelativeError FLOAT64>>
LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var responsiveImages = JSON.parse($._responsive_images);
  responsiveImages = responsiveImages['responsive-images'];

  return responsiveImages.map(({sizesAbsoluteError, sizesRelativeError}) => ({
    sizesAbsoluteError,
    sizesRelativeError
  }));
} catch (e) {
  return [];
}
''';

SELECT
  _TABLE_SUFFIX AS client,
  COUNTIF(image.sizesRelativeError < 0.05) AS small_relative_error,
  COUNT(0) AS total,
  COUNTIF(image.sizesRelativeError < 0.05) / COUNT(0) AS pct
FROM
  `httparchive.pages.2021_07_01_*`,
  UNNEST(getSizesAccuracy(payload)) AS image
GROUP BY
  client
