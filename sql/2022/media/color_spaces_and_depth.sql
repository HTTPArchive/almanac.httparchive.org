#standardSQL
# info on color depth and spaces – will need to be further filtered/aggregated, but this is everything

WITH color_info AS (
  SELECT
    _TABLE_SUFFIX as client,
    JSON_EXTRACT( payload, '$._image_details.magick.depth') AS color_depth,
    JSON_EXTRACT( payload, '$._image_details.magick.colorspace') AS color_space,
    JSON_EXTRACT( payload, '$._image_details.magick.properties.icc:description') AS description
  FROM
    `requests.2022_06_01_*`
  WHERE
    JSON_QUERY(payload, '$._image_details.magick.colorspace') IS NOT NULL
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
