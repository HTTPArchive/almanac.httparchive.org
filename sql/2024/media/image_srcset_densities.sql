#standardSQL
# distribution of the densities of srcset candidates
# image_srcset_densities.sql

CREATE TEMPORARY FUNCTION getSrcsetDensities(payload STRING)
RETURNS ARRAY<STRUCT<currentSrcDensity INT64, srcsetCandidateDensities ARRAY<FLOAT64>>>
LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var responsiveImages = JSON.parse($._responsive_images);
  responsiveImages = responsiveImages['responsive-images'];

  return responsiveImages.map(({currentSrcDensity, srcsetCandidateDensities}) => ({
    currentSrcDensity,
    srcsetCandidateDensities: srcsetCandidateDensities.map(density => Math.round(density * 100) / 100)
  }));
} catch (e) {
  return [];
}
''';

SELECT
  percentile,
  client,
  APPROX_QUANTILES(image.currentSrcDensity, 1000)[OFFSET(percentile * 10)] AS currentSrcDensity,
  APPROX_QUANTILES(srcsetCandidateDensity, 1000)[OFFSET(percentile * 10)] AS srcsetCandidateDensity
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    image
  FROM
    `httparchive.pages.2024_06_01_*`,
    UNNEST(getSrcsetDensities(payload)) AS image
),
  UNNEST(image.srcsetCandidateDensities) AS srcsetCandidateDensity,
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
