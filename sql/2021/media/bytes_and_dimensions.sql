CREATE TEMPORARY FUNCTION getSrcsetInfo(responsiveImagesJsonString STRING)
RETURNS ARRAY<STRUCT<imgURL STRING, approximateResourceWidth INT64, approximateResourceHeight INT64, byteSize INT64, bitsPerPixel NUMERIC, isPixel BOOL, isDataURL BOOL, resourceFormat STRING>>
LANGUAGE js AS '''

function pithyType( { contentType, url } ) {
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
      'jp2': 'jp2',
      'png': 'png',
      'gif': 'gif',
      'ico': 'ico',
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
      return 'unknown'; // switch between:
                        // `subtype`
                        //     to see everything, check if there's anything else worth capturing
                        // `'unknown'`
                        //     to make results manageable
  }

  // if it's a data url, take the mime type from there, done.
  if ( url &&
       typeof url === "string" ) {
      const match = url.toLowerCase().match( /^data:image\\/([\\w\\-\\.\\+]+)/ );
      if ( match && match[ 1 ] ) {
          return normalizeSubtype( match[ 1 ] );
      }
  }

  // if we get a content-type header, use it!
  if ( contentType &&
       typeof contentType === "string" ) {
      const match = contentType.toLowerCase().match( /image\\/([\\w\\-\\.\\+]+)/ );
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
                    .replace( /^(\\w+)[\\?\\&\\#].*/, '$1' ) // strip query params
              );
          }
      }
  }

  // otherwise throw up our hands
  return 'unknown';
  }

	const parsed = JSON.parse( responsiveImagesJsonString );
	if ( parsed && parsed.map ) {
        const dataRegEx = new RegExp('^data');
		return parsed.map( d => ({
            imgURL: d.url,
            approximateResourceWidth: Math.floor( d.approximateResourceWidth || 0 ),
            approximateResourceHeight: Math.floor( d.approximateResourceHeight || 0 ),
            byteSize: Math.floor( d.byteSize || 0 ),
            bitsPerPixel: parseFloat( d.bitsPerPixel || 0 ),
            isPixel: d.approximateResourceWidth == 1 && d.approximateResourceHeight == 1,
            isDataURL: dataRegEx.test(d.url),
            resourceFormat: pithyType({ contentType: d.mimeType, url: d.url })
		}) );
    }
''';

WITH imgs AS (
  SELECT
    _TABLE_SUFFIX as client, url as pageURL, imgURL, approximateResourceWidth, approximateResourceHeight, byteSize, bitsPerPixel, isPixel, isDataURL,
    ( approximateResourceWidth * approximateResourceHeight ) / 1000000 AS megapixels,
    ( approximateResourceWidth / approximateResourceHeight ) as aspectRatio,
    resourceFormat
  FROM `httparchive.pages.2021_07_01_*`, UNNEST(getSrcsetInfo( JSON_QUERY( JSON_VALUE( payload, '$._responsive_images' ), '$.responsive-images' ) ) )
), percentiles AS (
SELECT
    client,
    APPROX_QUANTILES(approximateResourceWidth, 100) as resourceWidthPercentiles,
    APPROX_QUANTILES(approximateResourceHeight, 100) AS resourceHeightPercentiles,
    APPROX_QUANTILES(aspectRatio, 100) AS aspectRatioPercentiles,
    APPROX_QUANTILES(megapixels, 100) AS megapixelsPercentiles,
    APPROX_QUANTILES(byteSize, 100) AS byteSizePercentiles,
    APPROX_QUANTILES(bitsPerPixel, 100) AS bitsPerPixelPercentiles,
    COUNT(0) as imgCount
FROM imgs
WHERE approximateResourceWidth > 1 AND approximateResourceHeight > 1
GROUP BY client
)
SELECT
    client,
    imgCount,
    resourceWidthPercentiles[OFFSET(0)] as resourceWidth_p0,
    resourceWidthPercentiles[OFFSET(25)] as resourceWidth_p25,
    resourceWidthPercentiles[OFFSET(50)] as resourceWidth_p50,
    resourceWidthPercentiles[OFFSET(75)] as resourceWidth_p75,
    resourceWidthPercentiles[OFFSET(90)] as resourceWidth_p90,
    resourceWidthPercentiles[OFFSET(100)] as resourceWidth_p100,
    resourceHeightPercentiles[OFFSET(0)] as resourceHeight_p0,
    resourceHeightPercentiles[OFFSET(25)] as resourceHeight_p25,
    resourceHeightPercentiles[OFFSET(50)] as resourceHeight_p50,
    resourceHeightPercentiles[OFFSET(75)] as resourceHeight_p75,
    resourceHeightPercentiles[OFFSET(90)] as resourceHeight_p90,
    resourceHeightPercentiles[OFFSET(100)] as resourceHeight_p100,
    aspectRatioPercentiles[OFFSET(0)] as aspectRatio_p0,
    aspectRatioPercentiles[OFFSET(25)] as aspectRatio_p25,
    aspectRatioPercentiles[OFFSET(50)] as aspectRatio_p50,
    aspectRatioPercentiles[OFFSET(75)] as aspectRatio_p75,
    aspectRatioPercentiles[OFFSET(90)] as aspectRatio_p90,
    aspectRatioPercentiles[OFFSET(100)] as aspectRatio_p100,
    megapixelsPercentiles[OFFSET(0)] as megapixels_p0,
    megapixelsPercentiles[OFFSET(25)] as megapixels_p25,
    megapixelsPercentiles[OFFSET(50)] as megapixels_p50,
    megapixelsPercentiles[OFFSET(75)] as megapixels_p75,
    megapixelsPercentiles[OFFSET(90)] as megapixels_p90,
    megapixelsPercentiles[OFFSET(100)] as megapixels_p100,
    byteSizePercentiles[OFFSET(0)] as byteSize_p0,
    byteSizePercentiles[OFFSET(25)] as byteSize_p25,
    byteSizePercentiles[OFFSET(50)] as byteSize_p50,
    byteSizePercentiles[OFFSET(75)] as byteSize_p75,
    byteSizePercentiles[OFFSET(90)] as byteSize_p90,
    byteSizePercentiles[OFFSET(100)] as byteSize_p100,
    bitsPerPixelPercentiles[OFFSET(0)] as bitsPerPixel_p0,
    bitsPerPixelPercentiles[OFFSET(25)] as bitsPerPixel_p25,
    bitsPerPixelPercentiles[OFFSET(50)] as bitsPerPixel_p50,
    bitsPerPixelPercentiles[OFFSET(75)] as bitsPerPixel_p75,
    bitsPerPixelPercentiles[OFFSET(90)] as bitsPerPixel_p90,
    bitsPerPixelPercentiles[OFFSET(100)] as bitsPerPixel_p100
FROM percentiles
ORDER BY imgCount DESC
