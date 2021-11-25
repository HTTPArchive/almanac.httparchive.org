#standardSQL
# images mimetype vs extension
SELECT
  client,
  ext,
  mimetype,
  COUNT(0) AS ext_mime_image_count,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_images,
  SAFE_DIVIDE(COUNT(0), SUM(COUNT(0)) OVER (PARTITION BY client)) AS total_image_pct,
  SAFE_DIVIDE(COUNT(0), SUM(COUNT(0)) OVER (PARTITION BY client, ext)) AS ext_pct,
  SAFE_DIVIDE(COUNT(0), SUM(COUNT(0)) OVER (PARTITION BY client, mimetype)) AS mime_pct
FROM
  `httparchive.almanac.requests`
WHERE
  date = '2021-07-01' AND
  type = 'image'
GROUP BY
  client,
  ext,
  mimetype
HAVING
  ext_mime_image_count > 10000
ORDER BY
  ext_mime_image_count DESC,
  client
