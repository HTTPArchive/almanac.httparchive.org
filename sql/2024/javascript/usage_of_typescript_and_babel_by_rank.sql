#standardSQL
# Number of pages using TypeScript or Babel grouped by rank

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

WITH pages AS (
  SELECT
    _TABLE_SUFFIX AS client,
    rank_grouping,
    url AS page
  FROM
    `httparchive.summary_pages.2024_06_01_*`,
    UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS rank_grouping
  WHERE
    rank <= rank_grouping
),

pages_sourcemaps AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    getSourceMaps(payload) AS sourcemaps
  FROM
    `httparchive.pages.2024_06_01_*`
)

SELECT
  client,
  rank_grouping AS rank,
  COUNTIF(sourcemaps.isBabel = true) AS use_babel,
  COUNTIF(sourcemaps.isTypeScript = true) AS use_typescript,
  COUNT(0) AS total_pages_with_sourcemaps,
  COUNTIF(sourcemaps.isBabel = true) / COUNT(0) AS pct_use_babel,
  COUNTIF(sourcemaps.isTypeScript = true) / COUNT(0) AS pct_use_typescript
FROM
  pages_sourcemaps
JOIN
  pages
USING
  (client, page)
WHERE
  sourcemaps.isPublic = true
GROUP BY
  client,
  rank_grouping
ORDER BY
  client,
  rank_grouping
