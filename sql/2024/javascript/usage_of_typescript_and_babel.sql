#standardSQL
# Number of pages using TypeScript or Babel

# returns boolean whether the page uses Babel or TypeScript
CREATE TEMPORARY FUNCTION getSourceMaps(javascript JSON)
RETURNS STRUCT<hasSourceMaps BOOL, isPublic BOOL, isBabel BOOL, isTypeScript BOOL>
LANGUAGE js AS '''
try {
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
  COUNTIF(getSourceMaps(custom_metrics.javascript).isBabel) AS use_babel,
  COUNTIF(getSourceMaps(custom_metrics.javascript).isTypeScript) AS use_typescript,
  COUNTIF(getSourceMaps(custom_metrics.javascript).isPublic) AS uses_sourcemaps,
  COUNTIF(getSourceMaps(custom_metrics.javascript).isBabel) / COUNTIF(getSourceMaps(custom_metrics.javascript).isPublic) AS pct_source_maps_use_babel,
  COUNTIF(getSourceMaps(custom_metrics.javascript).isTypeScript) / COUNTIF(getSourceMaps(custom_metrics.javascript).isPublic) AS pct_source_maps_use_typescript,
  COUNT(0) AS total_pages,
  COUNTIF(getSourceMaps(custom_metrics.javascript).isBabel) / COUNT(0) AS pct_use_babel,
  COUNTIF(getSourceMaps(custom_metrics.javascript).isTypeScript) / COUNT(0) AS pct_use_typescript
FROM
  `httparchive.crawl.pages`
WHERE
  date = '2024-06-01' AND
  is_root_page
GROUP BY
  client
ORDER BY
  client
