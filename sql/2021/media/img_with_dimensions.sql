#standardSQL
# usage meta open graph

# extracts the data about width, height and alt from the new customer metric
# using this, counts and reports on the usage for each attribute
CREATE TEMPORARY FUNCTION get_image_info(responsiveString STRING)
RETURNS ARRAY<STRUCT<hasWidth INT64, hasHeight INT64, hasAlt INT64, hasReservedLayoutDimension INT64>>
LANGUAGE js AS '''
try {
  let result = Array()
  const responsiveImages = JSON.parse(responsiveString)
  if(responsiveImages &&  responsiveImages['responsive-images']){
  for(const image of responsiveImages["responsive-images"]){
    result.push({
      hasWidth: image.hasWidth ? 1 : 0,
      hasHeight: image.hasHeight ? 1 : 0,
      hasAlt: image.hasAlt ? 1 : 0,
      hasReservedLayoutDimension: image.reservedLayoutDimensions ? 1 : 0
    })
  }}
  return result
} catch(e) {
  return [];
}
''';

SELECT
  client,
  COUNT(0) AS images,
  COUNTIF(hasWidth = 1) AS hasWidth,
  COUNTIF(hasHeight = 1) AS hasHeight,
  COUNTIF(hasAlt = 1) AS hasAlt,
  COUNTIF(hasReservedLayoutDimension = 1) AS hasDimensions,
  SAFE_DIVIDE(COUNTIF(hasWidth = 1), COUNT(0)) AS percHasWidth,
  SAFE_DIVIDE(COUNTIF(hasHeight = 1), COUNT(0)) AS percHasHeight,
  SAFE_DIVIDE(COUNTIF(hasAlt = 1), COUNT(0)) AS percHasAlt,
  SAFE_DIVIDE(COUNTIF(hasReservedLayoutDimension = 1), COUNT(0)) AS percHasDimensions
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    hasWidth,
    hasHeight,
    hasAlt,
    hasReservedLayoutDimension
  FROM
    `httparchive.pages.2021_07_01_*`,
    UNNEST(get_image_info(JSON_VALUE(payload, '$._responsive_images')))
)
GROUP BY
  client
