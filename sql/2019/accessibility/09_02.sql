#standardSQL
# 09_02: % of pages having minimum set of accessible elements
# Compliant pages have: header, footer, nav, and main (or [role=main]) elements
CREATE TEMPORARY FUNCTION getCompliantElements(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var elements = JSON.parse($._element_count);
  if (Array.isArray(elements) || typeof elements != 'object') return [];
  var compliantElements = new Set(['header', 'footer', 'nav', 'main']);
  return Object.keys(elements).filter(e => compliantElements.has(e));
} catch (e) {
  return [];
}
''';

SELECT
  client,
  COUNT(DISTINCT page) AS pages,
  total,
  ROUND(COUNT(DISTINCT page) * 100 / total, 2) AS pct
FROM (SELECT _TABLE_SUFFIX AS client, url AS page, getCompliantElements(payload) AS compliant_elements FROM `httparchive.pages.2019_07_01_*`)
JOIN (SELECT client, page, REGEXP_CONTAINS(body, '(?i)role=[\'"]?main') AS has_role_main FROM `httparchive.almanac.summary_response_bodies` WHERE date = '2019-07-01' AND firstHtml)
USING (client, page)
JOIN (SELECT _TABLE_SUFFIX AS client, COUNT(0) AS total FROM `httparchive.pages.2019_07_01_*` GROUP BY _TABLE_SUFFIX)
USING (client)
WHERE
  'header' IN UNNEST(compliant_elements) AND
  'footer' IN UNNEST(compliant_elements) AND
  'nav' IN UNNEST(compliant_elements) AND ('main' IN UNNEST(compliant_elements) OR has_role_main)
GROUP BY
  client,
  total
