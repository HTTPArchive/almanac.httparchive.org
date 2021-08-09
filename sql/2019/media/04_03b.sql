#standardSQL
# 04_03: Image Frequency by MimeType

SELECT
  client,
  webImageType AS imageType,
  COUNT(0) AS pageCount,
  COUNTIF(hits > 0) AS frequencyCount,
  ROUND(100 * COUNTIF(hits > 0) / COUNT(0), 2) AS pct,
  SUM(hits) AS totalHits,
  SUM(bytes) AS totalBytes,
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
    SUM(IF(LOWER(imageType) = LOWER(webImageType), hits, 0)) AS hits,
    SUM(IF(LOWER(webImageType) = LOWER(imageType), bytes, 0)) AS bytes
  FROM
  (
    SELECT
      client,
      page,
      NULLIF(IF(REGEX_CONTAINS(mimetype, r'(?i)^application|^applicaton|^binary|^image$|^multipart|^media|^$|^text/html|^text/plain|\d|array|unknown|undefined|\*|string|^img|^images|^text|\%2f|\(|ipg$|jpe$|jfif'), format, LOWER(REGEXP_REPLACE(REGEXP_REPLACE(mimetype, r'(?is).*image[/\\](?:x-)?|[\."]|[ +,;]+.*$', ''), r'(?i)pjpeg|jpeg', 'jpg'))), '') AS imageType,
      COUNT(0) AS hits,
      SUM(respSize) AS bytes
    FROM `httparchive.almanac.requests3`

    WHERE
      # many 404s ANDredirects show up as image/gif
      status = 200 AND

      # we are trying to catch images. WPO populates the format for media but it uses a file extension guess.
      #So we exclude mimetypes that aren't image or where the format couldn't be guessed by WPO
      (format <> '' OR mimetype LIKE 'image%') AND

      # many image/gifs are really beacons with 1x1 pixel, but svgs can get caught in the mix
      (respSize > 1500 OR REGEXP_CONTAINS(mimetype, r'svg')) AND

      # strip favicon requests
      format <> 'ico' AND

      # strip video mimetypes ANDother favicons
      NOT REGEXP_CONTAINS(mimetype, r'video|ico')
    GROUP BY
      client,
      page,
      imageType
  )
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
