SELECT
  client,
  percentile,
  is_root_page,
    CASE
    WHEN LOWER(JSON_VALUE(summary.mimeType)) = 'image/avif' OR LOWER(JSON_VALUE(summary.ext)) = 'avif' THEN 'avif'
    WHEN LOWER(JSON_VALUE(summary.mimeType)) = 'image/bmp' OR LOWER(JSON_VALUE(summary.ext)) = 'bmp' THEN 'bmp'
    WHEN LOWER(JSON_VALUE(summary.mimeType)) = 'image/gif' OR LOWER(JSON_VALUE(summary.ext)) = 'gif' THEN 'gif'
    WHEN LOWER(JSON_VALUE(summary.mimeType)) IN ('image/x-icon', 'image/vnd.microsoft.icon') OR LOWER(JSON_VALUE(summary.ext)) = 'ico' THEN 'ico'
    WHEN LOWER(JSON_VALUE(summary.mimeType)) IN ('image/jpg', 'image/jpeg')  OR LOWER(JSON_VALUE(summary.ext)) IN('jpeg', 'jpg') THEN 'jpg'
    WHEN LOWER(JSON_VALUE(summary.mimeType)) IN ('image/png', 'image/png') OR LOWER(JSON_VALUE(summary.ext)) = 'png' THEN 'png'
    WHEN LOWER(JSON_VALUE(summary.mimeType)) = 'image/svg+xml' OR LOWER(JSON_VALUE(summary.ext)) = 'svg' THEN 'svg'
    WHEN LOWER(JSON_VALUE(summary.mimeType)) IN ('image/webp', 'webp') OR LOWER(JSON_VALUE(summary.ext)) = 'webp' THEN 'webp'
    WHEN LOWER(JSON_VALUE(summary.mimeType)) IN ('video/mp4', 'video/mpeg') OR LOWER(JSON_VALUE(summary.ext)) = 'mpeg' THEN 'mpeg'
    WHEN LOWER(JSON_VALUE(summary.mimeType)) = 'video/webm' OR LOWER(JSON_VALUE(summary.ext)) = 'webm' THEN 'webm'
    WHEN LOWER(JSON_VALUE(summary.mimeType)) = 'video/quicktime' OR LOWER(JSON_VALUE(summary.ext)) IN ('mov', 'qt') THEN 'quicktime'
    WHEN LOWER(JSON_VALUE(summary.mimeType)) = 'video/webp' THEN 'webp Video'
    ELSE 'other/unknown'
  END AS media_format,
  APPROX_QUANTILES(CAST(JSON_VALUE(summary.respBodySize) AS INT64) / 1024, 1000)[OFFSET(percentile * 10)] AS resp_size
FROM
  `httparchive.crawl.requests`,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
WHERE
  date = '2025-07-01' AND
  type IN ('image','video')
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
