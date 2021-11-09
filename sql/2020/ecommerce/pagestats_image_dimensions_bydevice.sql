#standardSQL
# 13_06c: Distribution of image dimensions

## $4.11 run

CREATE TEMPORARY FUNCTION getImageDimensions(payload STRING)
RETURNS ARRAY<STRUCT<height INT64, width INT64>> LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var images = JSON.parse($._Images);
  return images.map(i => ({height: i.naturalHeight, width: i.naturalWidth}));
} catch (e) {
  return [];
}
''';

SELECT
  percentile,
  _TABLE_SUFFIX AS client,
  APPROX_QUANTILES(image.width, 1000)[OFFSET(percentile * 10)] AS image_width,
  APPROX_QUANTILES(image.height, 1000)[OFFSET(percentile * 10)] AS image_height
FROM
  `httparchive.pages.2020_08_01_*`
JOIN
  `httparchive.technologies.2020_08_01_*`
USING (_TABLE_SUFFIX, url),
  UNNEST(getImageDimensions(payload)) AS image,
  UNNEST([10, 25, 50, 75, 90]) AS percentile
WHERE
  category = 'Ecommerce'
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
