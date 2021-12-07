#standardSQL
# Percent of requests with and without minification
CREATE TEMPORARY FUNCTION getUnminifiedJsBytes(audit STRING)
RETURNS ARRAY<INT64> LANGUAGE js AS '''
try {
  var $ = JSON.parse(audit);
  return $.details.items.map(({wastedBytes}) => wastedBytes);
} catch (e) {
  return [];
}
''';

SELECT
  IF(unminified_js_kbytes <= 200, CEIL(unminified_js_kbytes / 10) * 10, 200) AS unminified_js_kbytes,
  COUNT(0) AS pages,
  SUM(COUNT(0)) OVER () AS total,
  COUNT(0) / SUM(COUNT(0)) OVER () AS pct
FROM (
  SELECT
    test.url AS page,
    SUM(IFNULL(unminified_js_bytes, 0)) / 1024 AS unminified_js_kbytes
  FROM
    `httparchive.lighthouse.2020_08_01_mobile` AS test
  LEFT JOIN
    UNNEST(getUnminifiedJsBytes(JSON_EXTRACT(report, "$.audits['unminified-javascript']"))) AS unminified_js_bytes
  GROUP BY
    page)
GROUP BY
  unminified_js_kbytes
ORDER BY
  unminified_js_kbytes
