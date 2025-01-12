#standardSQL
# what's the largest image per page? (by bytes)
# largest_image_per_page_bytes.sql

CREATE TEMPORARY FUNCTION largestImage(payload STRING)
RETURNS INT64
LANGUAGE js AS '''
try {

  var $ = JSON.parse(payload);
  var responsiveImages = JSON.parse($._responsive_images);
  responsiveImages = responsiveImages['responsive-images'];

  return responsiveImages.reduce( ( acc, cv ) => {
    const bytes = cv.byteSize;
    if ( bytes > acc ) {
      acc = bytes;
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
  APPROX_QUANTILES(largestImageBytes, 1000)[OFFSET(percentile * 10)] AS largestImageBytesize
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    largestImage(payload) AS largestImageBytes
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
