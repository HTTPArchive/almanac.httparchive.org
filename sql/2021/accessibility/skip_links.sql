#standardSQL
# % of pages having skip links
CREATE TEMPORARY FUNCTION getEarlyHash(payload STRING)
RETURNS INT64 LANGUAGE js AS '''
try {
  const almanac = JSON.parse(payload);
  return almanac['seo-anchor-elements'].earlyHash;
} catch (e) {
  return 0;
}
''';

SELECT
  _TABLE_SUFFIX AS client,
  COUNTIF(getEarlyHash(JSON_EXTRACT_SCALAR(payload, '$._almanac')) > 0) AS pages,
  COUNT(0) AS total,
  COUNTIF(getEarlyHash(JSON_EXTRACT_SCALAR(payload, '$._almanac')) > 0) / COUNT(0) AS pct
FROM
  `httparchive.pages.2021_07_01_*`
GROUP BY
  client
