#standardSQL
# 04_03: Image Frequency by MimeType

SELECT
  client,
  webImageType AS imageType,
  count(0) as pageCount,
  countif(hits > 0) as frequencyCount,
  round(100*countif(hits > 0) / count(0), 2) as pct,
  sum(hits) as totalHits,
  sum(bytes) as totalBytes,
  APPROX_QUANTILES(hits, 1000)[OFFSET(100)] AS hits_p10,
  APPROX_QUANTILES(hits, 1000)[OFFSET(250)] AS hits_p25,
  APPROX_QUANTILES(hits, 1000)[OFFSET(500)] AS hits_p50,
  APPROX_QUANTILES(hits, 1000)[OFFSET(750)] AS hits_p75,
  APPROX_QUANTILES(hits, 1000)[OFFSET(900)] AS hits_p90,
  APPROX_QUANTILES(hits, 1000)[OFFSET(990)] AS hits_p99,
  APPROX_QUANTILES(bytes, 1000)[OFFSET(100)] AS bytes_p10,
  APPROX_QUANTILES(bytes, 1000)[OFFSET(250)] AS bytes_p25,
  APPROX_QUANTILES(bytes, 1000)[OFFSET(500)] AS bytes_p50,
  APPROX_QUANTILES(bytes, 1000)[OFFSET(750)] AS bytes_p75,
  APPROX_QUANTILES(bytes, 1000)[OFFSET(900)] AS bytes_p90,
  APPROX_QUANTILES(bytes, 1000)[OFFSET(990)] AS bytes_p99
FROM
(
  SELECT
    client,
    page,
    webImageType,
    sum(if(lower(imageType) = lower(webImageType), hits, 0)) hits,
    sum(if(lower(webImageType) = lower(imageType), bytes, 0)) bytes
  FROM
  (
    SELECT
      client,
      page,
      nullif(if(regexp_contains(mimetype, r'(?i)^application|^applicaton|^binary|^image$|^multipart|^media|^$|^text/html|^text/plain|\d|array|unknown|undefined|\*|string|^img|^images|^text|\%2f|\(|ipg$|jpe$|jfif'), format, lower(regexp_replace(regexp_replace(mimetype, r'(?is).*image[/\\](?:x-)?|[\."]|[ +,;]+.*$', ''), r'(?i)pjpeg|jpeg', 'jpg'))), '') as imageType,
      count(0) hits,
      sum(respSize) bytes
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
    GROUP BY
      client,
      page,
      imageType
  )  a
  CROSS JOIN UNNEST(['jpg', 'png', 'webp', 'gif', 'svg']) AS webImageType
  GROUP BY
    client,
    page,
    webImageType
)
GROUP BY
  client,
  imageType
ORDER BY
  client DESC,
  totalHits DESC
