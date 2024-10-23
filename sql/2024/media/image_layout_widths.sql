#standardSQL
# Distribution of image layout widths
# image_layout_widths.sql

CREATE TEMPORARY FUNCTION layoutDimensions(payload STRING)
RETURNS ARRAY<STRUCT<clientWidth INT64, clientHeight INT64>>
LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var responsiveImages = JSON.parse($._responsive_images);
  responsiveImages = responsiveImages['responsive-images'];

  return responsiveImages.map(({clientWidth, clientHeight}) => ({
    clientWidth,
    clientHeight
  }));
} catch (e) {
  return [];
}
''';

SELECT
  percentile,
  client,
  APPROX_QUANTILES(image.clientWidth, 1000)[OFFSET(percentile * 10)] AS clientWidth
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    image
  FROM
    `httparchive.pages.2024_06_01_*`,
    UNNEST(layoutDimensions(payload)) AS image
  WHERE
    image.clientWidth > 1
),
UNNEST([0, 10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
