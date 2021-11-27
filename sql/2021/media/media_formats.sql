CREATE TEMPORARY FUNCTION fixFormat(format STRING, mimeType STRING)
RETURNS STRING
LANGUAGE js AS '''
if (mimeType === "image/avif") {
  return "avif";
} else if (mimeType === "image/webp" || format==="webp") {
  return "webp";
} else {
  return format;
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
    fixFormat(format, mimeType) AS trueFormat
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2021-07-01' AND
    type = 'image' AND
    respSize > 0)
GROUP BY
  client,
  trueFormat
ORDER BY
  pctImages DESC
