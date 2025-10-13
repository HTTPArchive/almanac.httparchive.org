CREATE TEMPORARY FUNCTION getMediaFormat(mimeType STRING)
RETURNS STRING
LANGUAGE js AS '''
if (mimeType === "image/avif") {
  return "avif";
} else if (mimeType === "image/bmp") {
  return "bmp";
} else if (mimeType === "image/gif") {
  return "gif";
} else if (mimeType === "image/x-icon" || mimeType === "image/vnd.microsoft.icon") {
  return "ico";
} else if (mimeType === "image/jpg" || mimeType === "image/jpeg") {
  return "jpg";
} else if (mimeType === "image/png" || mimeType === "Image/png") {
  return "png";
} else if (mimeType === "image/svg+xml") {
  return "svg";
} else if (mimeType === "image/webp" || mimeType==="webp") {
  return "webp";
} if (mimeType === "video/mp4" ||  mimeType === "video/mpeg") {
  return "mpeg";
} else if (mimeType === "video/webm") {
  return "webm";
} else if (mimeType === "video/quicktime") {
  return "quicktime";
} else if (mimeType === "video/webp") {
  return "webp Video";
}else {
  return "other/unknown";
}
''';

SELECT
  client,
  percentile,
  is_root_page,
  getMediaFormat(JSON_VALUE(summary.mimeType)) AS media_format,
  APPROX_QUANTILES(CAST(JSON_VALUE(summary.respBodySize) AS INT64) / 1024, 1000)[OFFSET(percentile * 10)] AS resp_size
FROM
  `httparchive.crawl.requests`,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
WHERE
  date = '2025-07-01'
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
