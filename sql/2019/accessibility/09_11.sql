#standardSQL
# 09_11: % pages with headings that skip levels
CREATE TEMPORARY FUNCTION includesSkippedHeading(headings ARRAY<STRING>)
RETURNS BOOLEAN LANGUAGE js AS '''
var previous = null;
for (h of headings) {
  h = parseInt(h);
  if (previous && h > previous && (h - previous) > 1) {
    return true;
  }
  previous = h;
}
return false;
''';

SELECT
  client,
  COUNT(DISTINCT page) AS pages,
  total,
  ROUND(COUNT(DISTINCT page) * 100 / total, 2) AS pct
FROM (SELECT client, page, REGEXP_EXTRACT_ALL(body, '(?i)</h([1-6])>') AS headings FROM `httparchive.almanac.summary_response_bodies` WHERE date = '2019-07-01' AND firstHtml)
JOIN (SELECT _TABLE_SUFFIX AS client, COUNT(0) AS total FROM `httparchive.pages.2019_07_01_*` GROUP BY _TABLE_SUFFIX)
USING (client)
WHERE
  includesSkippedHeading(headings)
GROUP BY
  client,
  total
