#standardSQL
# usage meta open graph

# extracts the data about width, height and alt from the new customer metric
# using this, counts and reports on the usage for each attribute
CREATE TEMPORARY FUNCTION get_image_info(responsiveString STRING)
RETURNS ARRAY<STRUCT<hasWidth INT64, hasHeight INT64, hasAlt INT64, hasReservedLayoutDimension INT64>>
LANGUAGE js AS '''
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
''';
SELECT 
    client,
    COUNT(0) AS images,
    COUNTIF(hasWidth = 1) as hasWidth,
    COUNTIF(hasHeight=1) as hasHeight,
    COUNTIF(hasAlt=1) as hasAlt,
    COUNTIF(hasReservedLayoutDimension=1) as hasDimensions,
    SAFE_DIVIDE(COUNTIF(hasWidth = 1), COUNT(0)) as percHasWidth,
    SAFE_DIVIDE(COUNTIF(hasHeight = 1), COUNT(0)) as percHasHeight,
    SAFE_DIVIDE(COUNTIF(hasAlt = 1), COUNT(0)) as percHasAlt,
    SAFE_DIVIDE(COUNTIF(hasReservedLayoutDimension=1), COUNT(0)) as percHasDimensions
FROM  (
    SELECT
        _TABLE_SUFFIX AS client,
        hasWidth,
        hasHeight,
        hasAlt,
        hasReservedLayoutDimension        
    FROM 
        `httparchive.pages.2021_08_01_*`, 
        UNNEST(get_image_info(JSON_VALUE(payload, '$._responsive_images')))
)
GROUP BY client
    