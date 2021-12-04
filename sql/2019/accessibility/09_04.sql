#standardSQL
# 09_04: % of pages having more than one "main" landmark
CREATE TEMPORARY FUNCTION getMainCount(payload STRING)
RETURNS INT64 LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var elements = JSON.parse($._element_count);
  if (Array.isArray(elements) || typeof elements != 'object') return 0;
  return elements['main'] || 0;
} catch (e) {
  return 0;
}
''';

SELECT
  client,
  main_elements + main_roles AS main_landmarks,
  COUNT(DISTINCT page) AS pages,
  total,
  ROUND(COUNT(DISTINCT page) * 100 / total, 2) AS pct
FROM
  (SELECT _TABLE_SUFFIX AS client, url AS page, getMainCount(payload) AS main_elements FROM `httparchive.pages.2019_07_01_*`)
JOIN
  (SELECT client, page, ARRAY_LENGTH(REGEXP_EXTRACT_ALL(body, '(?i)role=[\'"]?main')) AS main_roles FROM `httparchive.almanac.summary_response_bodies` WHERE date = '2019-07-01' AND firstHtml)
USING
  (client, page)
JOIN
  (SELECT _TABLE_SUFFIX AS client, COUNT(0) AS total FROM `httparchive.pages.2019_07_01_*` GROUP BY _TABLE_SUFFIX)
USING (client)
GROUP BY
  client,
  total,
  main_landmarks
ORDER BY
  pages / total DESC
