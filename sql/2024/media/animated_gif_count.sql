#standardSQL
# what percent of gifs are animated?
# animated_gif_count.sql

# ImageMagick reports big images as having, e.g., "1.29097M" pixels. This means ~1.2 million pixels, but BigQuery doesn't know that.
CREATE TEMPORARY FUNCTION magickPixels(imageMagickNumberString STRING)
RETURNS INT64
LANGUAGE js AS r'''

if (!imageMagickNumberString) { return null; }
const matched = imageMagickNumberString.match(/([\d\.]+)(\w+)?$/);
const multiples = {
  'K': 1e3,
  'M': 1e6,
  'G': 1e9,
  'T': 1e12
}
if ( matched && matched[1] ) {
  return Math.round(
    parseFloat( matched[1] ) * ( multiples[ matched[2] ] || 1 )
  );
} else {
  return null;
}

''';

SELECT
  _TABLE_SUFFIX AS client,
  COUNT(0) AS total_gifs,
  COUNTIF(CAST(JSON_VALUE(payload, '$._image_details.animated') AS BOOL)) AS total_animated_gifs,
  COUNTIF(CAST(JSON_VALUE(payload, '$._image_details.animated') AS BOOL)) / COUNT(0) AS pct_animated_gifs
FROM
  `requests.2024_06_01_*`
WHERE
  JSON_VALUE(payload, '$._image_details.detected_type') = 'gif' AND
  magickPixels(JSON_VALUE(payload, '$._image_details.magick.numberPixels')) > 1
GROUP BY
  client
