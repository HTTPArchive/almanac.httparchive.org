CREATE TEMPORARY FUNCTION getSrcsetInfo(responsiveImagesJsonString STRING)
RETURNS ARRAY<STRUCT<imgURL STRING, approximateResourceWidth INT64, approximateResourceHeight INT64, byteSize INT64, isPixel BOOL, isDataURL BOOL>>
LANGUAGE js AS '''

	const parsed = JSON.parse( responsiveImagesJsonString );
	if ( parsed && parsed.map ) {
        const dataRegEx = new RegExp('^data');
		return parsed.map( d => ({
            imgURL: d.url,
            approximateResourceWidth: d.approximateResourceWidth,
            approximateResourceHeight: d.approximateResourceHeight,
            byteSize: d.byteSize,
            isPixel: d.approximateResourceWidth == 1 && d.approximateResourceHeight == 1,
            isDataURL: dataRegEx.test(d.url)
		}) );
    }
''';

WITH imgs AS (
  SELECT
    _TABLE_SUFFIX as client, url as pageURL, imgURL, approximateResourceWidth, approximateResourceHeight, byteSize, isPixel, isDataURL,
    approximateResourceWidth * approximateResourceHeight AS pixels
  FROM `httparchive.pages.2021_07_01_*`, UNNEST(getSrcsetInfo( JSON_QUERY( JSON_VALUE( payload, '$._responsive_images' ), '$.responsive-images' ) ) )
), one_pixel_images AS (
    SELECT
        client,
        COUNTIF(isPixel) as total_one_pixel_images,
        COUNTIF( NOT( approximateResourceWidth > 0 ) ) AS total_unloaded_imgs
  FROM imgs
  GROUP BY client
), img_sums_excluding_one_pixel_images AS (
  SELECT
    client,
    COUNT(0) as total_imgs,
    SUM(approximateResourceWidth) as total_width,
    SUM(approximateResourceHeight) as total_height,
    SUM(pixels) as total_pixels,
    SUM(byteSize) as total_bytes
  FROM imgs
  WHERE isPixel = false AND approximateResourceWidth > 0
  GROUP BY client
), img_averages AS (
    SELECT
        client,
        SAFE_DIVIDE( total_width, total_imgs ) AS average_width,
        SAFE_DIVIDE( total_height, total_imgs ) AS average_height,
        SAFE_DIVIDE( total_pixels, total_imgs ) AS average_pixels,
        SAFE_DIVIDE( total_bytes, total_imgs ) AS average_bytes
    FROM img_sums_excluding_one_pixel_images
)
SELECT
  *
FROM one_pixel_images
JOIN img_sums_excluding_one_pixel_images USING (client)
JOIN img_averages USING (client)
