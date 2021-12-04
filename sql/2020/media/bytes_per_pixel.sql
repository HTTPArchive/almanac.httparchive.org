#standardSQL
# Bytes per pixel per image format
CREATE TEMPORARY FUNCTION getImages(payload STRING)
RETURNS ARRAY<STRUCT<url STRING, naturalWidth INT64, naturalHeight INT64, width INT64, height INT64>> LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var images = JSON.parse($._Images) || [];
  return images.map(({url, naturalHeight, naturalWidth, width, height}) => ({url, naturalHeight: Number.parseInt(naturalHeight) || 0, naturalWidth: Number.parseInt(naturalWidth) || 0, width: Number.parseInt(width) || 0, height: Number.parseInt(height) || 0}));
} catch (e) {}
return null;
''';

SELECT
  client,
  imageType,
  COUNT(0) AS count,
  APPROX_QUANTILES(IF(imageType = 'svg' AND pixels > 0, pixels, naturalPixels), 1000)[OFFSET(100)] AS pixels_p10,
  APPROX_QUANTILES(IF(imageType = 'svg' AND pixels > 0, pixels, naturalPixels), 1000)[OFFSET(250)] AS pixels_p25,
  APPROX_QUANTILES(IF(imageType = 'svg' AND pixels > 0, pixels, naturalPixels), 1000)[OFFSET(500)] AS pixels_p50,
  APPROX_QUANTILES(IF(imageType = 'svg' AND pixels > 0, pixels, naturalPixels), 1000)[OFFSET(750)] AS pixels_p75,
  APPROX_QUANTILES(IF(imageType = 'svg' AND pixels > 0, pixels, naturalPixels), 1000)[OFFSET(900)] AS pixels_p90,
  APPROX_QUANTILES(bytes, 1000)[OFFSET(100)] AS bytes_p10,
  APPROX_QUANTILES(bytes, 1000)[OFFSET(250)] AS bytes_p25,
  APPROX_QUANTILES(bytes, 1000)[OFFSET(500)] AS bytes_p50,
  APPROX_QUANTILES(bytes, 1000)[OFFSET(750)] AS bytes_p75,
  APPROX_QUANTILES(bytes, 1000)[OFFSET(900)] AS bytes_p90,
  APPROX_QUANTILES(ROUND(bytes / IF(imageType = 'svg' AND pixels > 0, pixels, naturalPixels), 4), 1000)[OFFSET(100)] AS bpp_p10,
  APPROX_QUANTILES(ROUND(bytes / IF(imageType = 'svg' AND pixels > 0, pixels, naturalPixels), 4), 1000)[OFFSET(250)] AS bpp_p25,
  APPROX_QUANTILES(ROUND(bytes / IF(imageType = 'svg' AND pixels > 0, pixels, naturalPixels), 4), 1000)[OFFSET(500)] AS bpp_p50,
  APPROX_QUANTILES(ROUND(bytes / IF(imageType = 'svg' AND pixels > 0, pixels, naturalPixels), 4), 1000)[OFFSET(750)] AS bpp_p75,
  APPROX_QUANTILES(ROUND(bytes / IF(imageType = 'svg' AND pixels > 0, pixels, naturalPixels), 4), 1000)[OFFSET(900)] AS bpp_p90
FROM
  (
    SELECT
      _TABLE_SUFFIX AS client,
      p.url AS page,
      image.url AS url,
      image.width AS width,
      image.height AS height,
      image.naturalWidth AS naturalWidth,
      image.naturalHeight AS naturalHeight,
      IFNULL(image.width, 0) * IFNULL(image.height, 0) AS pixels,
      IFNULL(image.naturalWidth, 0) * IFNULL(image.naturalHeight, 0) AS naturalPixels
    FROM
      `httparchive.pages.2020_08_01_*` p
    CROSS JOIN UNNEST(getImages(payload)) AS image
    WHERE
      image.naturalHeight > 0 AND
      image.naturalWidth > 0
  )
LEFT JOIN
  (
    SELECT
      client,
      page,
      url,
      NULLIF(if(REGEXP_CONTAINS(mimetype, r'(?i)^application|^applicaton|^binary|^image$|^multipart|^media|^$|^text/html|^text/plain|\d|array|unknown|undefined|\*|string|^img|^images|^text|\%2f|\(|ipg$|jpe$|jfif'), format, LOWER(REGEXP_REPLACE(REGEXP_REPLACE(mimetype, r'(?is).*image[/\\](?:x-)?|[\."]|[ +,;]+.*$', ''), r'(?i)pjpeg|jpeg', 'jpg'))), '') AS imageType,
      respSize AS bytes
    FROM `httparchive.almanac.requests`

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
  )
USING (client, page, url)
WHERE
  naturalPixels > 0 AND
  bytes > 0 AND
  imageType IN ('jpg', 'png', 'webp', 'gif', 'svg')
GROUP BY
  client,
  imageType
ORDER BY
  client DESC,
  imageType DESC
