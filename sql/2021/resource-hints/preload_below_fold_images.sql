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
image_stats_tb AS (
  SELECT
    _TABLE_SUFFIX AS client,
    preloadedNonViewportImages(JSON_EXTRACT_SCALAR(payload,
        '$._almanac'),
      JSON_EXTRACT_SCALAR(payload,
        '$._Images')) AS num_non_viewport_preload_images
  FROM
    `httparchive.pages.2021_07_01_*`
)

SELECT
  client,
  num_non_viewport_preload_images,
  COUNT(0) AS pages,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  image_stats_tb
GROUP BY
  client,
  num_non_viewport_preload_images
