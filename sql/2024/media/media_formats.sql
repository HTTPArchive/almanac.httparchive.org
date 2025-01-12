#standardSQL
# Format adoption
# media_formats.sql
# ❕ Updated in 2024 to use all.requests instead of almanac.requests

CREATE TEMPORARY FUNCTION fixMimeType(mimeType STRING)
RETURNS STRING
LANGUAGE js AS '''
if (mimeType === "image/avif") {
  return "avif";
} else if (mimeType === "image/webp" || mimeType==="webp") {
  return "webp";
} else if (mimeType === 'image/jpg' || mimeType === 'image/jpeg') {
  return 'jpg';
} else if (mimeType === 'image/png' || mimeType === 'Image/png') {
  return 'png';
} else if (mimeType === 'image/gif') {
  return 'gif';
} else if (mimeType === 'image/svg+xml') {
  return 'svg';
} else if (mimeType === 'image/x-icon' || mimeType === 'image/vnd.microsoft.icon') {
  return 'ico';
} else if (mimeType === 'image/bmp') {
  return 'bmp';
} else {
  return 'other/unknown';
}
''';

SELECT
  client,
  trueFormat,
  COUNT(DISTINCT NET.HOST(url)) AS hosts,
  COUNT(DISTINCT page) AS pages,
  COUNT(0) AS freqImages,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS totalImages,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pctImages
FROM (
  SELECT
    client,
    page,
    url,
    fixMimeType(JSON_VALUE(payload, '$.response.content.mimeType')) AS trueFormat
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-06-01' AND
    type = 'image' AND
    JSON_VALUE(summary, '$.respBodySize') IS NOT NULL
)
GROUP BY
  client,
  trueFormat
ORDER BY
  pctImages DESC
