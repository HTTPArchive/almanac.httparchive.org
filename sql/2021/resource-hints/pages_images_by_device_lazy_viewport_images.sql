  # standardSQL
  # Lazily loaded viewport images
CREATE TEMPORARY FUNCTION
  countLazilyLoadedVPImages(imagesJsonStr STRING)
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
WITH
  ImageStats AS (
  SELECT
    _TABLE_SUFFIX AS client,
    countLazilyLoadedVPImages( JSON_EXTRACT_SCALAR(payload,
        '$._Images')) AS res,
    JSON_EXTRACT_SCALAR(payload,
      '$._almanac') AS almanac,
    JSON_QUERY(payload,
      '$._Images') AS images
  FROM
    -- `httparchive.sample_data.pages*`
    `httparchive.pages.2021_07_01_*` )
SELECT
  client,
  res AS numLazyViewportImages,
  COUNT(0) AS numPages
FROM
  ImageStats
WHERE
  res > 0
GROUP BY
  client,
  res