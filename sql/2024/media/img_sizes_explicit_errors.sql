#standardSQL
# how many sizes attributes had explicit errors?
# also how many were implicit (100vw)
# img_sizes_explicit_errors.sql

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
  COUNT(0) AS images_with_sizes,
  SAFE_DIVIDE(COUNTIF(respimg.sizesWasImplicit = TRUE), COUNT(0)) AS implicit_pct,
  SAFE_DIVIDE(COUNTIF(respimg.sizesWasImplicit = FALSE), COUNT(0)) AS explicit_pct,
  SAFE_DIVIDE(COUNTIF(respimg.sizesParseError = TRUE), COUNT(0)) AS parseError_pct,
  SAFE_DIVIDE(COUNTIF(respimg.srcsetHasWDescriptors = TRUE), COUNT(0)) AS wDescriptor_pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    a.url AS pageUrl,
    respimg
  FROM
    `httparchive.pages.2024_06_01_*` AS a,
    UNNEST(get_responsive_settings(JSON_EXTRACT_SCALAR(payload, '$._responsive_images'))) AS respimg
  WHERE
    respimg.srcsetHasWDescriptors
)
GROUP BY
  client
