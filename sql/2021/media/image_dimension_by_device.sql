#standardSQL
# Taken from Performance 2020 chapter
# Removed the condition to look for only ECommerce

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
  category,
  _TABLE_SUFFIX AS client,
  APPROX_QUANTILES(image.width, 1000)[OFFSET(percentile * 10)] AS image_width,
  APPROX_QUANTILES(image.height, 1000)[OFFSET(percentile * 10)] AS image_height
FROM
  `httparchive.pages.2021_08_01_*`
JOIN
  `httparchive.technologies.2021_08_01_*`
USING (_TABLE_SUFFIX, url),
UNNEST(getImageDimensions(payload)) AS image,
UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client,
  category
ORDER BY
  percentile,
  client