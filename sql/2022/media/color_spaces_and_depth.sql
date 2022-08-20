#standardSQL
# info on color depth and spaces – will need to be further filtered/aggregated, but this is everything
WITH color_info AS (
SELECT
  _TABLE_SUFFIX as client,
  JSON_EXTRACT( payload, '$._image_details.magick.depth') as color_depth,
  JSON_EXTRACT( payload, '$._image_details.magick.colorspace') as color_space,
  JSON_EXTRACT( payload, '$._image_details.magick.properties.icc:description') as description
FROM `requests.2022_06_01_*`
WHERE
  JSON_QUERY(payload, '$._image_details.magick.colorspace') IS NOT NULL
),
totals AS (
  SELECT client, COUNT(0) as total FROM color_info
  GROUP BY client
),
counts AS (
  SELECT
    client, color_depth, color_space, description, count(0) as count
  FROM color_info
  GROUP BY client, color_depth, color_space, description
)
SELECT *, count / total as pct
FROM counts JOIN totals USING ( client )
ORDER BY count DESC
