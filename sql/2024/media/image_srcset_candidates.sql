#standardSQL
# distribution of number of srcset candidates
# image_srcset_candidates.sql

CREATE TEMPORARY FUNCTION getNumberOfSrcsetCandidates(payload STRING)
RETURNS ARRAY<INT64>
LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var responsiveImages = JSON.parse($._responsive_images);
  responsiveImages = responsiveImages['responsive-images'];

  return responsiveImages.map(({srcsetCandidateDensities}) =>
    (srcsetCandidateDensities && srcsetCandidateDensities.length) ? srcsetCandidateDensities.length : null
  );
} catch (e) {
  return [];
}
''';

SELECT
  percentile,
  client,
  APPROX_QUANTILES(numberOfCandidates, 1000)[OFFSET(percentile * 10)] AS numberOfCandidates
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    numberOfCandidates
  FROM
    `httparchive.pages.2024_06_01_*`,
    UNNEST(getNumberOfSrcsetCandidates(payload)) AS numberOfCandidates
),
UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
