#standardSQL
# Measuring img loaded bytes and dimensions

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
    _TABLE_SUFFIX AS client,
    url AS pageURL,
    imgURL,
    approximateResourceWidth,
    approximateResourceHeight,
    byteSize,
    bitsPerPixel,
    isPixel,
    isDataURL, (approximateResourceWidth * approximateResourceHeight) / 1000000 AS megapixels, (approximateResourceWidth / approximateResourceHeight) AS aspectRatio,
    resourceFormat
  FROM
    `httparchive.pages.2022_06_01_*`,
    UNNEST(getSrcsetInfo(JSON_QUERY(JSON_VALUE(payload, '$._responsive_images'), '$.responsive-images')))
),

percentiles AS (
  SELECT
    client,
    APPROX_QUANTILES(approximateResourceWidth, 1000) AS resourceWidthPercentiles,
    APPROX_QUANTILES(approximateResourceHeight, 1000) AS resourceHeightPercentiles,
    APPROX_QUANTILES(aspectRatio, 1000) AS aspectRatioPercentiles,
    APPROX_QUANTILES(megapixels, 1000) AS megapixelsPercentiles,
    APPROX_QUANTILES(byteSize, 1000) AS byteSizePercentiles,
    APPROX_QUANTILES(bitsPerPixel, 1000) AS bitsPerPixelPercentiles,
    COUNT(0) AS imgCount
  FROM
    imgs
  WHERE
    approximateResourceWidth > 1 AND
    approximateResourceHeight > 1
  GROUP BY
    client
)

SELECT
  percentile,
  client,
  imgCount,
  resourceWidthPercentiles[OFFSET(percentile * 10)] AS resourceWidth,
  resourceHeightPercentiles[OFFSET(percentile * 10)] AS resourceHeight,
  aspectRatioPercentiles[OFFSET(percentile * 10)] AS aspectRatio,
  megapixelsPercentiles[OFFSET(percentile * 10)] AS megapixels,
  byteSizePercentiles[OFFSET(percentile * 10)] AS byteSize,
  bitsPerPixelPercentiles[OFFSET(percentile * 10)] AS bitsPerPixel
FROM
  percentiles,
  UNNEST([0, 10, 25, 50, 75, 90, 100]) AS percentile
ORDER BY
  imgCount DESC,
  percentile
