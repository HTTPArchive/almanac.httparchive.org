#standardSQL
# Usage of native lazy loading
CREATE TEMPORARY FUNCTION usesLoadingLazy(payload STRING)
RETURNS BOOLEAN LANGUAGE js AS '''
try {
  const almanac = JSON.parse(payload);

  let found = false;
  for (const node of almanac.images.imgs.nodes) {
    if (node.loading === "lazy") {
      found = true;
      break;
    }
  }

  return found;
} catch (e) {
  return false;
}
''';
SELECT
  client,
  COUNTIF(total_img > 0) AS pages_with_images,

  COUNTIF(uses_loading_lazy) AS pages_using_loading_attribute,
  COUNTIF(uses_loading_lazy) / COUNTIF(total_img > 0) AS pct_pages_using_loading_attribute
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    SAFE_CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._almanac'), '$.images.imgs.total') AS INT64) AS total_img,
    usesLoadingLazy(JSON_EXTRACT_SCALAR(payload, '$._almanac')) AS uses_loading_lazy
  FROM
    `httparchive.pages.2021_07_01_*`
)
GROUP BY
  client
