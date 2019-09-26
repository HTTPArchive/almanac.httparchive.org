#standardSQL
# 04_11: Bytes per pixel per image format
CREATE TEMPORARY FUNCTION getImages(payload STRING)
RETURNS ARRAY<STRUCT<img_url STRING, naturalHeight INT64, naturalWidth INT64>> LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var images = JSON.parse($._Images);
  return images.map(({url, naturalHeight, naturalWidth}) => ({img_url: url, naturalHeight, naturalWidth}));
} catch (e) {
  return null;
}
''';

SELECT
  percentile,
  client,
  format,
  APPROX_QUANTILES(SAFE_DIVIDE(respSize, naturalWidth * naturalHeight), 1000)[OFFSET(percentile * 10)] AS bytes_per_pixel
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    image.img_url AS url,
    image.naturalWidth,
    image.naturalHeight
  FROM
    `httparchive.pages.2019_07_01_*`,
    UNNEST(getImages(payload)) AS image)
JOIN
  `httparchive.almanac.summary_requests`
USING
  (client, page, url),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client,
  format
ORDER BY
  percentile,
  client,
  format