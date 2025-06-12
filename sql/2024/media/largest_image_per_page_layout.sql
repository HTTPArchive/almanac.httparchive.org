#standardSQL
# what's the largest image per page? (by *css* pixels)
# largest_image_per_page_layout.sql

CREATE TEMPORARY FUNCTION widestImage(payload STRING)
RETURNS INT64
LANGUAGE js AS '''
try {

  var $ = JSON.parse(payload);
  var responsiveImages = JSON.parse($._responsive_images);
  responsiveImages = responsiveImages['responsive-images'];

  return responsiveImages.reduce( ( acc, cv ) => {
    const w = cv.clientWidth;
    if ( w > acc ) {
      acc = w;
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
  APPROX_QUANTILES(widestImageCSSpx, 1000)[OFFSET(percentile * 10)] AS widestImageLayoutWidth
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    widestImage(payload) AS widestImageCSSpx
  FROM
    `httparchive.pages.2024_06_01_*`
),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
