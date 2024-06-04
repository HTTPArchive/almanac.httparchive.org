#standardSQL
# 09_13: % pages with headings out of order
CREATE TEMPORARY FUNCTION includesUnorderedHeading(headings ARRAY<STRING>)
RETURNS BOOLEAN LANGUAGE js AS '''
var previous = null;
var seen = new Set();
for (h of headings) {
  h = parseInt(h);
  if (previous && h < previous && !seen.has(h)) {
    return true;
  }
  previous = h;
  seen.add(h);
}
return false;
''';

SELECT
  client,
  COUNT(DISTINCT page) AS pages,
  total,
  ROUND(COUNT(DISTINCT page) * 100 / total, 2) AS pct
FROM (SELECT client, page, REGEXP_EXTRACT_ALL(LOWER(body), '<h([1-6])') AS headings FROM `httparchive.almanac.summary_response_bodies` WHERE date = '2019-07-01' AND firstHtml)
JOIN (SELECT _TABLE_SUFFIX AS client, COUNT(0) AS total FROM `httparchive.pages.2019_07_01_*` GROUP BY _TABLE_SUFFIX)
USING (client)
WHERE
  includesUnorderedHeading(headings)
GROUP BY
  client,
  total
