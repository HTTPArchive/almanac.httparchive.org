#standardSQL
# Format adoption
# video_formats.sql
# ❕ Updated in 2024 to use all.requests instead of almanac.requests

CREATE TEMPORARY FUNCTION fixMimeType(mimeType STRING)
RETURNS STRING
LANGUAGE js AS '''
if (mimeType === "video/mp4" ||  mimeType === "video/mpeg") {
  return "mpeg";
} else if (mimeType === "video/webm") {
  return "webm";
} else if (mimeType === "video/quicktime") {
  return "quicktime";
} else if (mimeType === "video/webp") {
  return "webp";
} else {
  return mimeType;
}
''';

SELECT
  client,
  trueFormat,
  COUNT(DISTINCT NET.HOST(url)) AS hosts,
  COUNT(DISTINCT page) AS pages,
  COUNT(0) AS freqVideos,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS totalVideos,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pctVideos
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
    type = 'video' AND
    JSON_VALUE(summary, '$.respBodySize') IS NOT NULL
)
GROUP BY
  client,
  trueFormat
ORDER BY
  pctVideos DESC
