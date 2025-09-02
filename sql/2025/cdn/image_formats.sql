#standardSQL
# image_formats.sql : Distribution of image mime types by client

SELECT
  client,
  COUNTIF(image_type = 'BMP') AS bmp,
  COUNTIF(image_type = 'APNG') AS apng,
  COUNTIF(image_type = 'AVIF') AS avif,
  COUNTIF(image_type = 'GIF') AS gif,
  COUNTIF(image_type = 'JPEG') AS jpeg,
  COUNTIF(image_type = 'PNG') AS png,
  COUNTIF(image_type = 'SVG') AS svg,
  COUNTIF(image_type = 'WEBP') AS webp,
  COUNTIF(image_type = 'ICO') AS ico,
  COUNTIF(image_type = 'TIFF') AS tiff
FROM (
  SELECT
    client,
    CASE
      WHEN mimeType = 'image/bmp' THEN 'BMP'
      WHEN mimeType = 'image/apng' THEN 'APNG'
      WHEN mimeType = 'image/avif' THEN 'AVIF'
      WHEN mimeType = 'image/gif' THEN 'GIF'
      WHEN mimeType = 'image/jpeg' OR mimeType = 'image/jpg' THEN 'JPEG'
      WHEN mimeType = 'image/png' THEN 'PNG'
      WHEN mimeType = 'image/svg+xml' THEN 'SVG'
      WHEN mimeType = 'image/webp' THEN 'WEBP'
      WHEN mimeType = 'image/x-icon' THEN 'ICO'
      WHEN mimeType = 'image/tiff' THEN 'TIFF'
    END AS image_type

  FROM (
    SELECT client, JSON_EXTRACT_SCALAR(summary, '$.mimeType') AS mimeType FROM `httparchive.all.requests` WHERE date = '2024-06-01' AND
      type = 'image'
  )
)
GROUP BY
  client
ORDER BY
  client
