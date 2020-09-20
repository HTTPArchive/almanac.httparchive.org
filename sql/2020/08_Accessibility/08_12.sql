#standardSQL
# 08_12: % of pages having skip links
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
  COUNT(DISTINCT url) AS pages,
  total,
  COUNT(DISTINCT url) / total AS pct
FROM
  `httparchive.pages.2020_08_01_*`
JOIN (
  SELECT
    _TABLE_SUFFIX,
    COUNT(0) AS total
  FROM
    `httparchive.pages.2020_08_01_*`
  GROUP BY
    _TABLE_SUFFIX
)
USING (_TABLE_SUFFIX)
WHERE
  getEarlyHash(JSON_EXTRACT_SCALAR(payload, "$._almanac")) > 0
GROUP BY
  client,
  total
