#standardSQL
# 04_03: Images by MimeType

SELECT
  client,
  # we need to normalize the image filetype. However, content-type often lies, but WPO uses extensions.
  # without running `identify` on each image bytes, we are going to try a sanitize approach and fall back to WPOs file extension match
  # I found this less problematic than trying to do the inverse by selecting only image/ results and falling back to WPO. It's a mess either way
  NULLIF(IF(REGEX_CONTAINS(mimetype, r'(?i)^application|^applicaton|^binary|^image$|^multipart|^media|^$|^text/html|^text/plain|\d|array|unknown|undefined|\*|string|^img|^images|^text|\%2f|\(|ipg$|jpe$|jfif'), format, LOWER(REGEXP_REPLACE(REGEXP_REPLACE(mimetype, r'(?is).*image[/\\](?:x-)?|[\."]|[ +,;]+.*$', ''), r'(?i)pjpeg|jpeg', 'jpg'))), '') AS imageType,
  --   NULLIF(IF(REGEX_CONTAINS(mimetype, r'(?is)^image/'), LOWER(REGEXP_REPLACE(REGEXP_REPLACE(mimetype, r'(?i)^image[/\\](?:x-)?|[\."]|[ +,;].*$', ''), r'(?i)pjpeg|jpeg', 'jpg')), format), '') AS imageType,

  # A future iteration could try and use the initator_type. however again WPO is very inconsistent with results and I dont' have time to debug
  -- json_extract_scalar(payload, '$._initiator_type'),
  # ideally we would use a normalized mimeType from `identify` or other magic byte tool
  -- mimetype,
  COUNT(0) AS hits,
  ROUND((COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client)), 2) AS hits_pct,
  SUM(respsize) AS bytes,
  ROUND((SUM(respsize) * 100 / SUM(SUM(respsize)) OVER (PARTITION BY client)), 2) AS bytes_pct,
  APPROX_QUANTILES(respSize, 1000)[OFFSET(100)] AS size_p10,
  APPROX_QUANTILES(respSize, 1000)[OFFSET(250)] AS size_p25,
  APPROX_QUANTILES(respSize, 1000)[OFFSET(500)] AS size_p50,
  APPROX_QUANTILES(respSize, 1000)[OFFSET(750)] AS size_p75,
  APPROX_QUANTILES(respSize, 1000)[OFFSET(900)] AS size_p90
FROM `httparchive.almanac.requests3`
WHERE
  # many 404s and redirects show up as image/gif
  status = 200 AND

  # we are trying to catch images. WPO populates the format for media but it uses a file extension guess.
  #So we exclude mimetypes that aren't image or where the format couldn't be guessed by WPO
  (format <> '' OR mimetype LIKE 'image%') AND

  # many image/gifs are really beacons with 1x1 pixel, but svgs can get caught in the mix
  (respSize > 1500 OR REGEXP_CONTAINS(mimetype, r'svg')) AND

  # strip favicon requests
  format <> 'ico' AND

  # strip video mimetypes and other favicons
  NOT REGEXP_CONTAINS(mimetype, r'video|ico')
GROUP BY
  client,
  imageType
ORDER BY
  client DESC,
  hits DESC
