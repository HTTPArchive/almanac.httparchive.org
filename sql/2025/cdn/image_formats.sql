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
  COUNTIF(image_type = 'TIFF') AS tiff,
  COUNTIF(image_type = 'OTHER') AS other
FROM (
  SELECT
    client,
    CASE
      WHEN LOWER(mimeType) = 'image/bmp' THEN 'BMP'
      WHEN LOWER(mimeType) = 'image/apng' THEN 'APNG'
      WHEN LOWER(mimeType) = 'image/avif' THEN 'AVIF'
      WHEN LOWER(mimeType) = 'image/gif' THEN 'GIF'
      WHEN LOWER(mimeType) IN ('image/jpeg', 'image/jpg') THEN 'JPEG'
      WHEN LOWER(mimeType) = 'image/png' THEN 'PNG'
      WHEN LOWER(mimeType) = 'image/svg+xml' THEN 'SVG'
      WHEN LOWER(mimeType) = 'image/webp' THEN 'WEBP'
      WHEN LOWER(mimeType) = 'image/x-icon' THEN 'ICO'
      WHEN LOWER(mimeType) = 'image/tiff' THEN 'TIFF'
      WHEN LOWER(mimeType) LIKE 'image/%' THEN 'OTHER'   -- <-- catch-all for uncommon image types
      ELSE NULL
    END AS image_type
  FROM (
    SELECT
      client,
      COALESCE(JSON_EXTRACT_SCALAR(summary, '$.mimeType'), '') AS mimeType
    FROM
      `httparchive.crawl.requests`
    WHERE
      date = '2025-07-01' AND
      type = 'image'
  )
)
GROUP BY
  client
ORDER BY
  client;
