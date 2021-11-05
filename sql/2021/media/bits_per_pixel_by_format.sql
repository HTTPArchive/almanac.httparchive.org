CREATE TEMP FUNCTION normalizeMimeType(contentType STRING, url STRING)
RETURNS STRING
LANGUAGE js AS r"""

const subtypeMap = {
    'svg+xml': 'svg',
    'svgz': 'svg',
    'jpeg': 'jpg',
    'jfif': 'jpg',
    'x-png': 'png',
    'vnd.microsoft.icon': 'ico',
    'x-icon': 'ico',
    'jxr': 'jxr',
    'vnd.ms-photo': 'jxr',
    'hdp': 'jxr',
    'wdp': 'jxr',
    'jp2': 'jp2',
    'jpf': 'jp2',
    'jpx': 'jp2',
    'jpm': 'jp2',
    'mj2': 'jp2',
    'x-jp2-container': 'jp2',
    'x-jp2-codestream': 'jp2',
    'x-jpeg2000-image': 'jp2',
    'heic': 'heif',
    'x-ms-bmp': 'bmp',
    'x-pict': 'pict',
    'tif': 'tiff',
    'x-tif': 'tiff',
    'x-tiff': 'tiff',
    'vnd.mozilla.apng': 'apng',
    // identities
    'apng': 'apng',
    'jpg': 'jpg',
    'png': 'png',
    'gif': 'gif',
    'webp': 'webp',
    'avif': 'avif',
    'tiff': 'tiff',
    'flif': 'flif',
    'heif': 'heif',
    'jxl': 'jxl',
    'avif-sequence': 'avif-sequence', // keep separate from single frames...
    'heic-sequence': 'heic-sequence',
    'bmp': 'bmp',
    'pict': 'pict'
};
function normalizeSubtype( subtype ) {
    if ( subtypeMap[ subtype ] ) {
        return subtypeMap[ subtype ];
    }
    return 'unknown'; // switch to subtype to see everything and see if there's anything else worth capturing
                    // or 'unknown' to make results manageable
}

// if it's a data url, take the mime type from there, done.
if ( url &&
     typeof url === "string" ) {
    const match = url.toLowerCase().match( /^data\:image\/([\w\d\-\.\+]+)/ );
    if ( match && match[ 1 ] ) {
        return normalizeSubtype( match[ 1 ] );
    }
}

// if we get a content-type header, use it!
if ( contentType &&
     typeof contentType === "string" ) {
    const match = contentType.toLowerCase().match( /image\/([\w\-\.\+]+)/ );
    if ( match && match[ 1 ] ) {
        return normalizeSubtype( match[ 1 ] );
    }
}

// otherwise fall back to extension in the URL
if ( url &&
     typeof url === "string" ) {
    const splitOnSlashes = url.split("/");
    if ( splitOnSlashes.length > 1 ) {
        const afterLastSlash = splitOnSlashes[ splitOnSlashes.length - 1 ],
              splitOnDots = afterLastSlash.split(".");
        if ( splitOnDots.length > 1 ) {
            return normalizeSubtype(
                splitOnDots[ splitOnDots.length - 1 ]
                .toLowerCase()
                .replace( /^(\w+)[\?\&\#].*/, '$1' ) // strip query params
            );
        }
    }
}

// otherwise throw up our hands
return 'unknown';

""";
WITH pages AS (
SELECT
    _TABLE_SUFFIX as client,
    url as pageURL,
    JSON_QUERY_ARRAY(
        JSON_VALUE(
            payload,
            "$._responsive_images"
        ),
        '$."responsive-images"'
    ) AS imgElements
FROM `httparchive.pages.2021_07_01_*`
), imgElements AS (
SELECT
    client,
	CAST( JSON_VALUE(imgElement, '$.bitsPerPixel') AS NUMERIC) as bitsPerPixel,
	CAST( ROUND( CAST( JSON_VALUE(imgElement, '$.approximateResourceWidth') AS NUMERIC ) ) AS INT64 ) as approximateResourceWidth,
	normalizeMimeType( JSON_VALUE(imgElement, '$.mimeType'), JSON_VALUE(imgElement, '$.url') ) as mimeType,
FROM pages CROSS JOIN UNNEST(imgElements) AS imgElement
), percentiles AS (
SELECT
    client,
    mimeType,
    COUNT(0) as number_of_images,
    APPROX_QUANTILES( bitsPerPixel, 100 ) as bpp_quantiles
FROM imgElements
WHERE approximateResourceWidth > 1 -- excludes <img>s with no currentSrc, and 1x1 trackers/spacers
GROUP BY mimeType, client
)
SELECT
    client,
    mimeType,
    number_of_images,
    bpp_quantiles[OFFSET(0)] as min_bpp,
    bpp_quantiles[OFFSET(10)] as p10_bpp,
    bpp_quantiles[OFFSET(25)] as p25_bpp,
    bpp_quantiles[OFFSET(50)] as p50_bpp,
    bpp_quantiles[OFFSET(75)] as p75_bpp,
    bpp_quantiles[OFFSET(90)] as p90_bpp,
    bpp_quantiles[OFFSET(100)] as max_bpp
FROM percentiles
ORDER BY number_of_images DESC
