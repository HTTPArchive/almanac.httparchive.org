WITH images_types AS (
  SELECT
    date,
    client,
    is_root_page,
    type,
    LOWER(JSON_VALUE(summary.mimeType)) AS mimeType,
    SAFE.INT64(summary.respBodySize) AS respBodySize,
    -- Only return the extension if the mimeType is missing or set to something generic like octet-stream
    IF(JSON_VALUE(summary.mimeType) = '' OR LOWER(JSON_VALUE(summary.mimeType)) LIKE '%octet-stream%', LOWER(JSON_VALUE(summary.ext)), NULL) AS usefulExt
  FROM
    `httparchive.crawl.requests`
  WHERE
    date = '2025-07-01' AND
    type IN ('image', 'video')
)

SELECT
  client,
  percentile,
  is_root_page,
  -- This can all be changed to `JSON_VALUE(summary.format) AS media_format` next year
  -- and also remove need for `images_types` CTE, but for now we need this
  -- See clean up in https://github.com/HTTPArchive/wptagent/pull/45
  CASE
    WHEN mimeType = 'image/avif' OR usefulExt = 'avif' THEN 'avif'
    WHEN mimeType = 'image/bmp' OR usefulExt = 'bmp' THEN 'bmp'
    WHEN mimeType = 'image/gif' OR usefulExt = 'gif' THEN 'gif'
    WHEN mimeType IN ('image/x-icon', 'image/vnd.microsoft.icon') OR usefulExt = 'ico' THEN 'ico'
    WHEN mimeType IN ('image/jpg', 'image/jpeg') OR usefulExt IN ('jpeg', 'jpg') THEN 'jpg'
    WHEN mimeType = 'image/png' OR usefulExt = 'png' THEN 'png'
    WHEN mimeType = 'image/svg+xml' OR usefulExt = 'svg' THEN 'svg'
    WHEN mimeType IN ('image/webp', 'webp') OR usefulExt = 'webp' THEN 'webp'
    WHEN mimeType IN ('video/mp4', 'video/mpeg') OR usefulExt = 'mpeg' THEN 'mpeg'
    WHEN mimeType = 'video/webm' OR usefulExt = 'webm' THEN 'webm'
    WHEN mimeType = 'video/quicktime' OR usefulExt = 'mov' THEN 'quicktime'
    WHEN mimeType = 'video/webp' THEN 'webp Video'
    ELSE 'other/unknown'
  END AS media_format,
  APPROX_QUANTILES(respBodySize / 1024, 1000)[OFFSET(percentile * 10)] AS resp_size
FROM
  images_types,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  client,
  percentile,
  media_format,
  is_root_page
ORDER BY
  media_format,
  client,
  is_root_page,
  percentile
