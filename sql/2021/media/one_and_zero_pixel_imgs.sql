CREATE TEMPORARY FUNCTION is1x1(payload STRING) RETURNS ARRAY<BOOLEAN> LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var images = JSON.parse($._Images);

  return images.map(i => {
    return i.naturalWidth <= 1 && i.naturalHeight <= 1;
  });
} catch (e) {
  return null;
}
''';

SELECT
  client,
  COUNT(DISTINCT IF(px, url, NULL)) AS px_pages,
  COUNT(DISTINCT url) AS total_pages,
  COUNT(DISTINCT IF(px, url, NULL)) / COUNT(DISTINCT url) AS pct_pages,
  COUNTIF(px) AS px_images,
  COUNT(0) AS total_images,
  COUNTIF(px) / COUNT(0) AS pct_images
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    px
  FROM
    `httparchive.pages.2021_07_01_*`,
    UNNEST(is1x1(payload)) AS px)
GROUP BY
  client
