#standardSQL
# 04_11a: Bytes per pixel per image format
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
  a.client,
  imageType,
  count(0) as count,
  APPROX_QUANTILES(if(imageType = 'svg' AND pixels > 0, pixels, naturalPixels), 1000)[OFFSET(100)] AS pixels_p10,
  APPROX_QUANTILES(if(imageType = 'svg' AND pixels > 0, pixels, naturalPixels), 1000)[OFFSET(250)] AS pixels_p25,
  APPROX_QUANTILES(if(imageType = 'svg' AND pixels > 0, pixels, naturalPixels), 1000)[OFFSET(500)] AS pixels_p50,
  APPROX_QUANTILES(if(imageType = 'svg' AND pixels > 0, pixels, naturalPixels), 1000)[OFFSET(750)] AS pixels_p75,
  APPROX_QUANTILES(if(imageType = 'svg' AND pixels > 0, pixels, naturalPixels), 1000)[OFFSET(900)] AS pixels_p90,
  APPROX_QUANTILES(bytes, 1000)[OFFSET(100)] AS bytes_p10,
  APPROX_QUANTILES(bytes, 1000)[OFFSET(250)] AS bytes_p25,
  APPROX_QUANTILES(bytes, 1000)[OFFSET(500)] AS bytes_p50,
  APPROX_QUANTILES(bytes, 1000)[OFFSET(750)] AS bytes_p75,
  APPROX_QUANTILES(bytes, 1000)[OFFSET(900)] AS bytes_p90,
  APPROX_QUANTILES(round(bytes/if(imageType = 'svg' AND pixels > 0, pixels, naturalPixels), 4), 1000)[OFFSET(100)] AS bpp_p10,
  APPROX_QUANTILES(round(bytes/if(imageType = 'svg' AND pixels > 0, pixels, naturalPixels), 4), 1000)[OFFSET(250)] AS bpp_p25,
  APPROX_QUANTILES(round(bytes/if(imageType = 'svg' AND pixels > 0, pixels, naturalPixels), 4), 1000)[OFFSET(500)] AS bpp_p50,
  APPROX_QUANTILES(round(bytes/if(imageType = 'svg' AND pixels > 0, pixels, naturalPixels), 4), 1000)[OFFSET(750)] AS bpp_p75,
  APPROX_QUANTILES(round(bytes/if(imageType = 'svg' AND pixels > 0, pixels, naturalPixels), 4), 1000)[OFFSET(900)] AS bpp_p90
FROM
(
  SELECT
    _TABLE_SUFFIX AS client,
    p.url AS page,
    image.url AS url,
    image.width width,
    image.height height,
    image.naturalWidth naturalWidth,
    image.naturalHeight naturalHeight,
    ifnull(image.width, 0) * ifnull(image.height, 0) pixels,
    ifnull(image.naturalWidth, 0) * ifnull(image.naturalHeight, 0) naturalPixels
  FROM
    `httparchive.pages.2019_07_01_*` p
    CROSS JOIN UNNEST(getImages(payload)) AS image
  WHERE
    image.naturalHeight > 0
    AND image.naturalWidth > 0
--  LIMIT 1000
) a
LEFT JOIN
(
    SELECT
      client,
      page,
      url,
      nullif(if(regexp_contains(mimetype, r'(?i)^application|^applicaton|^binary|^image$|^multipart|^media|^$|^text/html|^text/plain|\d|array|unknown|undefined|\*|string|^img|^images|^text|\%2f|\(|ipg$|jpe$|jfif'), format, lower(regexp_replace(regexp_replace(mimetype, r'(?is).*image[/\\](?:x-)?|[\."]|[ +,;]+.*$', ''), r'(?i)pjpeg|jpeg', 'jpg'))), '') as imageType,
      respSize as bytes
    FROM `httparchive.almanac.requests3`

    WHERE
      # many 404s and redirects show up as image/gif
      status = 200

      # we are trying to catch images. WPO populates the format for media but it uses a file extension guess.
      #So we exclude mimetypes that aren't image or where the format couldn't be guessed by WPO
      and (format <> '' OR mimetype like 'image%')

      # many image/gifs are really beacons with 1x1 pixel, but svgs can get caught in the mix
      and (respSize > 1500 OR regexp_contains(mimetype, r'svg'))

      # strip favicon requests
      and format <> 'ico'

      # strip video mimetypes and other favicons
      and not regexp_contains(mimetype, r'video|ico')
-- limit 1000
) b
ON (b.client = a.client AND a.page = b.page AND a.url = b.url)

WHERE
  naturalPixels > 0
  AND bytes > 0
  AND imageType in ('jpg', 'png', 'webp', 'gif', 'svg')
GROUP BY
  client,
  imageType
ORDER BY
  client desc