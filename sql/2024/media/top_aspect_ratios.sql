#standardSQL
# top particular aspect ratios
# top_aspect_ratios.sql

CREATE TEMPORARY FUNCTION getSrcsetInfo(responsiveImagesJsonString STRING)
RETURNS ARRAY<STRUCT<imgURL STRING, approximateResourceWidth INT64, approximateResourceHeight INT64, aspectRatio NUMERIC, resourceFormat STRING>>
LANGUAGE js AS '''
  const parsed = JSON.parse( responsiveImagesJsonString );
  if ( parsed && parsed.map ) {
    return parsed.map( d => ({
      imgURL: d.url,
      approximateResourceWidth: Math.floor( d.approximateResourceWidth || 0 ),
      approximateResourceHeight: Math.floor( d.approximateResourceHeight || 0 ),
      aspectRatio: ( d.approximateResourceWidth > 0 && d.approximateResourceHeight > 0 ?
        Math.round( ( d.approximateResourceWidth / d.approximateResourceHeight ) * 1000 ) / 1000 :
        -1 )
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
    aspectRatio
  FROM
    `httparchive.pages.2024_06_01_*`,
    UNNEST(getSrcsetInfo(JSON_QUERY(JSON_VALUE(payload, '$._responsive_images'), '$.responsive-images')))
  WHERE
    approximateResourceWidth > 1 AND
    approximateResourceHeight > 1
),

counts_per_client AS (
  SELECT
    client,
    COUNT(0) AS numberOfImagesPerClient
  FROM
    imgs
  GROUP BY
    client
),

counts_per_client_and_aspect_ratio AS (
  SELECT
    client,
    aspectRatio,
    COUNT(0) AS numberOfImagesPerClientAndAspectRatio
  FROM
    imgs
  GROUP BY
    client,
    aspectRatio
)

SELECT
  client,
  aspectRatio,
  numberOfImagesPerClientAndAspectRatio,
  SAFE_DIVIDE(numberOfImagesPerClientAndAspectRatio, numberOfImagesPerClient) AS percentOfImages
FROM
  counts_per_client_and_aspect_ratio
LEFT JOIN
  counts_per_client
USING (client)
ORDER BY
  percentOfImages DESC
