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
  trueFormat, 
  COUNT(*) freq, 
  COUNT(DISTINCT NET.HOST(url)) as Hosts, 
  COUNT(DISTINCT pageid) as Pages
FROM (
  SELECT 
    url, 
    pageid, 
    mimeType, 
    format, 
    fixFormat(format,mimeType) as trueFormat
  FROM `httparchive.sample_data.summary_requests_*`
  WHERE type="image" and respSize >0 
) 
GROUP BY trueFormat
ORDER BY freq DESC