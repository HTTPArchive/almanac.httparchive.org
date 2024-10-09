#standardSQL
# what is the bpp of animated vs non-animated GIFs?


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

# ImageMagick reports bytesizes in a friendly, human readable format. Just return bytes
CREATE TEMPORARY FUNCTION magickBytes(imageMagickNumberString STRING)
RETURNS INT64
LANGUAGE js AS r'''

if (!imageMagickNumberString) { return 0; }
const matched = imageMagickNumberString.match(/([\d\.]+)(\w+)$/);
const multiples = {
  'B': 1,
  'KB': 1e3,
  'MB': 1e6,
  'GB': 1e9,
  'TB': 1e12
}
if ( matched && matched[1] && matched[2] ) {
  return Math.round(
    parseFloat( matched[1] ) * multiples[ matched[2] ]
  );
} else {
  return null;
}

''';

WITH gifs AS (
  SELECT
    _TABLE_SUFFIX AS client,
    CAST(JSON_VALUE(payload, '$._image_details.animated') AS BOOL) AS is_animated, (magickBytes(JSON_VALUE(payload, '$._image_details.magick.filesize')) * 8) /
    magickPixels(JSON_VALUE(payload, '$._image_details.magick.numberPixels')) AS bits_per_pixel
  FROM
    `requests.2022_06_01_*`
  WHERE
    JSON_VALUE(payload, '$._image_details.detected_type') = 'gif' AND
    magickPixels(JSON_VALUE(payload, '$._image_details.magick.numberPixels')) > 1 AND
    JSON_VALUE(payload, '$._image_details.animated') IS NOT NULL
)

SELECT
  percentile,
  client,
  is_animated,
  APPROX_QUANTILES(bits_per_pixel, 1000)[OFFSET(percentile * 10)] AS bpp
FROM
  gifs,
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client,
  is_animated
ORDER BY
  percentile,
  client,
  is_animated
