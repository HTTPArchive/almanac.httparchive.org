#standardSQL
# Number of pages using TypeScript or Babel

# returns boolean whether the page uses Babel or TypeScript
CREATE TEMPORARY FUNCTION getSourceMaps(payload STRING)
RETURNS STRUCT<hasSourceMaps BOOL, isPublic BOOL, isBabel BOOL, isTypeScript BOOL>
LANGUAGE js AS '''
try {
  const $ = JSON.parse(payload);
  const javascript = JSON.parse($._javascript);

  if (javascript && javascript.sourceMaps) {
    const { sourceMaps } = javascript;

    return ({
      hasSourceMaps: Boolean(sourceMaps.count),
      isPublic: Boolean(Object.keys(sourceMaps.ext).length),
      isTypeScript: Boolean(sourceMaps.ext && (sourceMaps.ext.ts || sourceMaps.ext.tsx)),
      isBabel: Boolean(sourceMaps.babel)
    });
  }

  return {};
} catch (e) {
  return {};
}
''';

SELECT
  client,
  COUNTIF(sourcemaps.isBabel = true) AS use_babel,
  COUNTIF(sourcemaps.isTypeScript = true) AS use_typescript,
  COUNT(0) AS total_pages_with_sourcemaps,
  COUNTIF(sourcemaps.isBabel = true) / COUNT(0) AS pct_use_babel,
  COUNTIF(sourcemaps.isTypeScript = true) / COUNT(0) AS pct_use_typescript
FROM (
  SELECT
    client,
    page,
    getSourceMaps(payload) AS sourcemaps
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01'
)
WHERE
  sourcemaps.isPublic = true
GROUP BY
  client
