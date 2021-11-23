CREATE TEMPORARY FUNCTION getSrcsetInfo(responsiveImagesJsonString STRING)
RETURNS ARRAY<STRUCT<imgURL STRING, approximateResourceWidth INT64, approximateResourceHeight INT64, aspectRatio NUMERIC, isPortrait BOOL, isLandscape BOOL, isSquare BOOL>>
LANGUAGE js AS '''

	const parsed = JSON.parse( responsiveImagesJsonString );
	if ( parsed && parsed.map ) {
		return parsed.map( d => {
            const aspectRatio = ( d.approximateResourceWidth > 0 && d.approximateResourceHeight > 0 ?
                        Math.round( ( d.approximateResourceWidth / d.approximateResourceHeight ) * 1000 ) / 1000 :
                        -1 );
            return {
                imgURL: d.url,
                approximateResourceWidth: Math.floor( d.approximateResourceWidth || 0 ),
                approximateResourceHeight: Math.floor( d.approximateResourceHeight || 0 ),
                aspectRatio: aspectRatio,
                isPortrait: aspectRatio < 1 && aspectRatio > 0,
                isLandscape: aspectRatio > 1,
                isSquare: aspectRatio == 1
            }
        } );
    }
''';

WITH imgs AS (
  SELECT
    _TABLE_SUFFIX as client,
    url as pageURL,
    imgURL,
    approximateResourceWidth,
    approximateResourceHeight,
    isPortrait,
    isLandscape,
    isSquare
  FROM `httparchive.pages.2021_07_01_*`, UNNEST(getSrcsetInfo( JSON_QUERY( JSON_VALUE( payload, '$._responsive_images' ), '$.responsive-images' ) ) )
  WHERE approximateResourceWidth > 1 AND approximateResourceHeight > 1
), counts_per_client AS (
SELECT
    client,
    COUNTIF(isPortrait) as portraits,
    COUNTIF(isLandscape) as landscapes,
    COUNTIF(isSquare) as squares,
    COUNT(0) as numberOfImagesPerClient,
FROM imgs
GROUP BY client
)
SELECT
    client,
    SAFE_DIVIDE( portraits, numberOfImagesPerClient ) as percentPortrait,
    SAFE_DIVIDE( landscapes, numberOfImagesPerClient ) as percentLandscape,
    SAFE_DIVIDE( squares, numberOfImagesPerClient ) as percentSquare,
    numberOfImagesPerClient
FROM counts_per_client
