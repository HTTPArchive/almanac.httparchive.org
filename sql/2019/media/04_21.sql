#standardSQL
# 04_21: % of pages having a hero image
SELECT
  client,
  COUNTIF(has_hero_image) AS hero_image,
  COUNTIF(has_hero_bgimage) AS hero_bg_image,
  COUNT(0) AS total,
  ROUND(COUNTIF(has_hero_image) * 100 / COUNT(0), 2) AS pct_hero_img,
  ROUND(COUNTIF(has_hero_bgimage) * 100 / COUNT(0), 2) AS pct_hero_bgimg
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    JSON_EXTRACT_SCALAR(payload, "$['_heroElementTimes.Image']") IS NOT NULL AS has_hero_image,
    JSON_EXTRACT_SCALAR(payload, "$['_heroElementTimes.BackgroundImage']") IS NOT NULL AS has_hero_bgimage
  FROM
    `httparchive.pages.2019_07_01_*`
)
GROUP BY
  client
