# standardSQL
# Lazily loaded viewport images

CREATE TEMPORARY FUNCTION countLazilyLoadedVPImages(imagesJsonStr STRING)
RETURNS INT64
LANGUAGE js AS '''
try {
    var images = JSON.parse(imagesJsonStr)
    if (!Array.isArray(images) || typeof images != 'object' || images == null) return null;
    
    return images.filter(i => i.inViewport && (i.loading || "").toLowerCase() === "lazy").length
}
catch {
    return null
}
''' ;
WITH image_stats_tb AS (
  SELECT
    _TABLE_SUFFIX AS client,
    countLazilyLoadedVPImages( JSON_EXTRACT_SCALAR(payload, '$._Images')) AS num_lazy_viewport_images
  FROM
    `httparchive.pages.2021_07_01_*`
)

SELECT
  client,
  num_lazy_viewport_images,
  COUNT(0) AS pages,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  image_stats_tb
GROUP BY
  client,
  num_lazy_viewport_images
ORDER BY
  client,
  num_lazy_viewport_images
