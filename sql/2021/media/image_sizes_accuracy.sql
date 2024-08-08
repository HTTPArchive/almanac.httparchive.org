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
  percentile,
  client,
  APPROX_QUANTILES(image.sizesAbsoluteError, 1000)[OFFSET(percentile * 10)] AS sizesAbsoluteError,
  APPROX_QUANTILES(image.sizesRelativeError, 1000)[OFFSET(percentile * 10)] AS sizesRelativeError
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    image
  FROM
    `httparchive.pages.2021_07_01_*`,
    UNNEST(getSizesAccuracy(payload)) AS image
),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
