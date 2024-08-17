#standardSQL
# distribution of animated GIF framecounts
# animated_gif_framecount.sql

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

WITH framecounts AS (
  SELECT
    _TABLE_SUFFIX AS client,
    CAST(JSON_VALUE(payload, '$._image_details.metadata.GIF.FrameCount') AS NUMERIC) AS framecount
  FROM `requests.2024_06_01_*`
  WHERE
    JSON_VALUE(payload, '$._image_details.metadata.GIF.FrameCount') IS NOT NULL AND
    magickPixels(JSON_VALUE(payload, '$._image_details.magick.numberPixels')) > 1
)

SELECT
  percentile,
  client,
  APPROX_QUANTILES(framecount, 1000)[OFFSET(percentile * 10)] AS framecount
FROM
  framecounts,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
