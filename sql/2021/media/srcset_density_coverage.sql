#standardSQL
# images srcset candidates average
CREATE TEMPORARY FUNCTION getSrcsetInfo(responsiveImagesJsonString STRING)
RETURNS ARRAY<STRUCT<
  hasSrcset BOOL,
  srcsetHasXDescriptors BOOL,
  srcsetHasWDescriptors BOOL,
  srcsetCandidateDensities ARRAY<FLOAT64>,
  numberOfSrcsetCandidates INT64,
  minDensity FLOAT64,
  maxDensity FLOAT64
>>
LANGUAGE js AS '''
  const parsed = JSON.parse( responsiveImagesJsonString );
  if ( parsed && parsed.map ) {
    return parsed.map( d => {
      const result = {
          hasSrcset: d.hasSrcset,
          srcsetHasXDescriptors: d.srcsetHasXDescriptors,
          srcsetHasWDescriptors: d.srcsetHasXDescriptors,
          srcsetCandidateDensities: [],
          numberOfSrcsetCandidates: 0,
          minDensity: d.currentSrcDensity,
          maxDensity: d.currentSrcDensity
        };
      if ( d.srcsetCandidateDensities && d.srcsetCandidateDensities.map ) {
        const densities = d.srcsetCandidateDensities.map( n => parseFloat( n ) );
        result.srcsetCandidateDensities = densities;
        result.numberOfSrcsetCandidates = densities.length;
        result.minDensity = Math.min( ...densities );
        result.maxDensity = Math.max( ...densities );
        }
      return result;
    });
  }
''';

WITH imgs AS (
  SELECT
    _TABLE_SUFFIX AS client,
    hasSrcset,
    srcsetCandidateDensities,
    minDensity,
    maxDensity
  FROM
    `httparchive.pages.2021_07_01_*`,
    UNNEST(getSrcsetInfo(JSON_QUERY(JSON_VALUE(payload, '$._responsive_images'), '$.responsive-images')))
  WHERE
    srcsetHasXDescriptors = TRUE OR srcsetHasWDescriptors = TRUE
),

counts AS (
  SELECT
    client,
    COUNT(0) AS number_of_imgs_with_srcset,
    COUNTIF(minDensity <= 1 AND maxDensity >= 1.5) AS number_of_srcsets_covering_1x_to_1p5x,
    COUNTIF(minDensity <= 1 AND maxDensity >= 2) AS number_of_srcsets_covering_1x_to_2x,
    COUNTIF(minDensity <= 1 AND maxDensity >= 2.5) AS number_of_srcsets_covering_1x_to_2p5x,
    COUNTIF(minDensity <= 1 AND maxDensity >= 3) AS number_of_srcsets_covering_1x_to_3x
  FROM imgs
  GROUP BY client
)

SELECT
  client,
  number_of_imgs_with_srcset,
  number_of_srcsets_covering_1x_to_1p5x,
  number_of_srcsets_covering_1x_to_2x,
  number_of_srcsets_covering_1x_to_2p5x,
  number_of_srcsets_covering_1x_to_3x,
  number_of_srcsets_covering_1x_to_1p5x / number_of_imgs_with_srcset AS pct_of_srcsets_covering_1x_to_1p5x,
  number_of_srcsets_covering_1x_to_2x / number_of_imgs_with_srcset AS pct_of_srcsets_covering_1x_to_2x,
  number_of_srcsets_covering_1x_to_2p5x / number_of_imgs_with_srcset AS pct_of_srcsets_covering_1x_to_2p5x,
  number_of_srcsets_covering_1x_to_3x / number_of_imgs_with_srcset AS pct_of_srcsets_covering_1x_to_3x
FROM counts
