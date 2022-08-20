#standardSQL
# what percent of gifs are animated?

# ImageMagick reports big images as having, e.g., "1.29097M" pixels. This means ~1.2 million pixels, but BigQuery doesn't know that.
CREATE TEMPORARY FUNCTION magickMillions(imageMagickNumberString STRING)
RETURNS FLOAT64
LANGUAGE js AS '''

if (!imageMagickNumberString) { return 0; }
const matched = imageMagickNumberString.match( /(\\d+)\\.?(\\d+)?M$/ );
if ( matched && matched[1] ) {
  if ( matched[2] ) {
    // input had a decimal (e.g. "1.23456M")
    return `${ matched[1] }.${ matched[2] }e6`;
  } else {
    // input did not have a decimal (e.g. "1M")
    return `${ matched[1] }e6`;
  }
} else {
  return imageMagickNumberString;
}

''';

SELECT
  _TABLE_SUFFIX AS client,
  COUNT(0) as total_gifs,
  COUNTIF( CAST( JSON_VALUE(payload, '$._image_details.animated') AS BOOL ) ) total_animated_gifs,
  COUNTIF( CAST( JSON_VALUE(payload, '$._image_details.animated') AS BOOL ) ) / COUNT(0) AS pct_animated_gifs
FROM `requests.2022_06_01_*`
WHERE
  JSON_VALUE(payload, '$._image_details.detected_type') = "gif" AND
  magickMillions(JSON_VALUE(payload, '$._image_details.magick.numberPixels')) > 1
GROUP BY
  client
