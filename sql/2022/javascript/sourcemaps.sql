#standardSQL
# Number of pages with publicly available sourcemaps

# returns boolean whether the page has sourcemaps or not
CREATE TEMPORARY FUNCTION getSourceMaps(payload STRING)
RETURNS STRUCT<hasSourceMaps BOOL, isPublic BOOL>
LANGUAGE js AS '''
try {
  const $ = JSON.parse(payload);
  const javascript = JSON.parse($._javascript);

  if (javascript && javascript.sourceMaps) {
    const { sourceMaps } = javascript;

    return ({
      hasSourceMaps: Boolean(sourceMaps.count),
      isPublic: Boolean(Object.keys(sourceMaps.ext).length)
    });
  }

  return {};
} catch (e) {
  return {};
}
''';

SELECT
  client,
  COUNTIF(sourcemaps.hasSourceMaps = true) AS has_sourcemaps,
  COUNTIF(sourcemaps.isPublic = true) AS has_public_sourcemaps,
  COUNT(0) AS total_pages,
  COUNTIF(sourcemaps.hasSourceMaps = true) / COUNT(0) AS pct_has_sourcemaps,
  COUNTIF(sourcemaps.isPublic = true) / COUNT(0) AS pct_has_public_sourcemaps
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    getSourceMaps(payload) AS sourcemaps
  FROM
    `httparchive.pages.2022_06_01_*`
)
GROUP BY
  client
