#standardSQL
# 09_10: % of pages having skip links
CREATE TEMPORARY FUNCTION getEarlyHash(payload STRING)
RETURNS INT64 LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var almanac = JSON.parse($._almanac);
  return almanac['seo-anchor-elements'].earlyHash;
} catch (e) {
  return 0;
}
''';

SELECT
  _TABLE_SUFFIX AS client,
  COUNT(DISTINCT url) AS pages,
  total,
  ROUND(COUNT(DISTINCT url) * 100 / total, 2) AS pct
FROM
  `httparchive.pages.2019_07_01_*`
JOIN (SELECT _TABLE_SUFFIX, COUNT(0) AS total FROM `httparchive.pages.2019_07_01_*` GROUP BY _TABLE_SUFFIX)
USING (_TABLE_SUFFIX)
WHERE
  getEarlyHash(payload) > 0
GROUP BY
  client,
  total
