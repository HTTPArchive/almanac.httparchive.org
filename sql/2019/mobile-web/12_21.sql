#standardSQL
# 12_21: Sites using webp
SELECT
  client,
  COUNT(0) AS total_pages,
  COUNTIF(total_images > 0) AS total_with_images,
  COUNTIF(total_webp > 0) AS total_with_webp,
  ROUND(COUNTIF(total_webp > 0) * 100 / COUNTIF(total_images > 0), 2) AS total_sites_using_webp
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    pageid,
    COUNTIF(type = 'image') AS total_images,
    COUNTIF(type = 'image' AND format = 'webp') AS total_webp
  FROM
    `httparchive.summary_requests.2019_07_01_*`
  GROUP BY
    client,
    pageid
)
GROUP BY
  client
