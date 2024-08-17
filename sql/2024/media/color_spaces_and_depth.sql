#standardSQL
# info on color depth and spaces – will need to be further filtered/aggregated, but this is everything
# color_spaces_and_depth.sql

CREATE TEMPORARY FUNCTION magickMillions(imageMagickNumberString STRING)
RETURNS FLOAT64
LANGUAGE js AS r'''

if (!imageMagickNumberString) { return 0; }
const matched = imageMagickNumberString.match( /(\d+)\.?(\d+)?M$/ );
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

WITH color_info AS (
  SELECT
    _TABLE_SUFFIX AS client,
    JSON_EXTRACT(payload, '$._image_details.magick.depth') AS color_depth,
    JSON_EXTRACT(payload, '$._image_details.magick.colorspace') AS color_space,
    JSON_EXTRACT(payload, '$._image_details.magick.properties.icc:description') AS description
  FROM
    `requests.2024_06_01_*`
  WHERE
    JSON_QUERY(payload, '$._image_details.magick.colorspace') IS NOT NULL AND
    magickMillions(JSON_VALUE(payload, '$._image_details.magick.numberPixels')) > 1
),

totals AS (
  SELECT
    client,
    COUNT(0) AS total
  FROM
    color_info
  GROUP BY
    client
),

counts AS (
  SELECT
    client,
    color_depth,
    color_space,
    description,
    COUNT(0) AS count
  FROM
    color_info
  GROUP BY
    client,
    color_depth,
    color_space,
    description
)

SELECT
  *,
  count / total AS pct
FROM
  counts
JOIN
  totals
USING
  (client)
ORDER BY
  count DESC
