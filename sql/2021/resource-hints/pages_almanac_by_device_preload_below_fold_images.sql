# standardSQL
# Analyze the below the fold (i.e. not in the viewport) images that are preloaded 

CREATE TEMPORARY FUNCTION
  preloadedNonViewportImages(almanacJsonStr STRING,
    imagesJsonStr STRING)
  RETURNS INT64
  LANGUAGE js AS '''
try {
    var almanac = JSON.parse(almanacJsonStr)
    if (Array.isArray(almanac) || typeof almanac != 'object' || almanac == null) return null;

    var images = JSON.parse(imagesJsonStr)
    if (!Array.isArray(images) || typeof images != 'object' || images == null) return null;
    
    var nodes = almanac["link-nodes"]["nodes"]
    nodes = typeof nodes == 'string' ? JSON.parse(nodes) : nodes

    const imagesNotInVP = images.filter(i => !i.inViewport).map(i => i.url)
    const preloadedImages = new Set(nodes.filter(n => n['as'] === "image" && n['rel'] === 'preload').map(n => n.href))

    let unnecessaryImgPreloads = 0
    for(let i of imagesNotInVP) {
        if(preloadedImages.has(i)) {
            unnecessaryImgPreloads++
        }
    }

    return unnecessaryImgPreloads;
}
catch {
    return null
}
''';
WITH
  ImageStats AS (
  SELECT
    _TABLE_SUFFIX AS client,
    preloadedNonViewportImages(JSON_EXTRACT_SCALAR(payload,
        '$._almanac'),
      JSON_EXTRACT_SCALAR(payload,
        '$._Images')) AS res,
    JSON_EXTRACT_SCALAR(payload,
      '$._almanac') AS almanac,
    JSON_QUERY(payload,
      '$._Images') AS images
  FROM
    `httparchive.pages.2021_07_01_*`
    )
SELECT
  client,
  res AS numNonViewportPreloadedImages,
  COUNT(0) AS numPages
FROM
  ImageStats
GROUP BY
  client,
  res