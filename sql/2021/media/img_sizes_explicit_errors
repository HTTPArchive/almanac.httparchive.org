CREATE TEMPORARY FUNCTION get_responsive_settings(images_string STRING)
RETURNS ARRAY<STRUCT<sizes BOOL, srcsetHasWDescriptors BOOL, sizesWasImplicit BOOL, sizesParseError BOOL>>
LANGUAGE js AS '''
let result = [];
try {
const images_ = JSON.parse(images_string);
if (images_ && images_["responsive-images"]) {
    const images = images_["responsive-images"];
    for(const img of images) {
        result.push({
            sizes: img.hasSizes || false,
            srcsetHasWDescriptors: img.srcsetHasWDescriptors || false,
            sizesWasImplicit: img.sizesWasImplicit || false,
            sizesParseError: img.sizesParseError || false
        })
    }
}
} catch (e) {}
return result;
''';
SELECT
  client,
  count(0) AS images_with_sizes,
  SAFE_DIVIDE(COUNTIF(respimg.sizesWasImplicit = true), COUNT(0)) AS implicit_pct,
  SAFE_DIVIDE(COUNTIF(respimg.sizesWasImplicit = false), COUNT(0)) AS explicit_pct,
  SAFE_DIVIDE(COUNTIF(respimg.sizesParseError = true), COUNT(0)) AS parseError_pct,
  SAFE_DIVIDE(COUNTIF(respimg.srcsetHasWDescriptors = true), COUNT(0)) as wDescriptor_pct
FROM (
  SELECT
  _TABLE_SUFFIX AS client,
    a.url AS pageUrl,
    respimg
  FROM
    `httparchive.pages.2021_07_01_*` a,
    UNNEST(get_responsive_settings(JSON_EXTRACT_SCALAR(payload, '$._responsive_images'))) AS respimg
  WHERE
    respimg.srcsetHasWDescriptors = true
)
GROUP BY
  client
