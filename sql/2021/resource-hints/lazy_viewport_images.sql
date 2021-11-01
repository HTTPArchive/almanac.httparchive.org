# standardSQL
# Lazy-loaded images within the initial viewport

CREATE TEMPORARY FUNCTION hasLazyLoadedImagesInViewport(payload STRING)
RETURNS STRUCT<isLazy BOOL, inViewport BOOL>
LANGUAGE js AS '''
try {
  var images = JSON.parse(payload);
  if (!Array.isArray(images) || typeof images != "object" || images == null)
    return null;

  if (images.length) {
    const lazyLoadedImages = images.filter(
      (i) => (i.loading || "").toLowerCase() === "lazy"
    );

    if (lazyLoadedImages.length) {
      return {
        isLazy: !!lazyLoadedImages.length,
        inViewport: !!lazyLoadedImages.filter((i) => i.inViewport).length,
      };
    }

    return { isLazy: !!lazyLoadedImages.length };
  }

  return {};
} catch {
  return {};
}
''' ;

SELECT
  client,
  COUNTIF(has_lazy_images_in_viewport.inViewport) AS in_viewport,
  COUNTIF(has_lazy_images_in_viewport.isLazy) AS is_lazy,
  COUNTIF(has_lazy_images_in_viewport.inViewport) / COUNTIF(has_lazy_images_in_viewport.isLazy) AS pct,
  COUNT(0) AS total
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    hasLazyLoadedImagesInViewport(JSON_EXTRACT_SCALAR(payload, '$._Images')) AS has_lazy_images_in_viewport
  FROM
    `httparchive.pages.2021_07_01_*`
)
GROUP BY
  client
ORDER BY
  client
