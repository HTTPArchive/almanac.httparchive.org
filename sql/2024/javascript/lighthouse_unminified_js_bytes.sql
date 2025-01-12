#standardSQL
# Histogram of wasted bytes per page
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
  client,
  IF(unminified_js_kbytes <= 200, CEIL(unminified_js_kbytes / 10) * 10, 200) AS unminified_js_kbytes,
  COUNT(0) AS pages,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    lighthouse.url AS page,
    SUM(IFNULL(unminified_js_bytes, 0)) / 1024 AS unminified_js_kbytes
  FROM
    `httparchive.lighthouse.2024_06_01_*` AS lighthouse
  LEFT JOIN
    UNNEST(getUnminifiedJsBytes(JSON_EXTRACT(report, "$.audits['unminified-javascript']"))) AS unminified_js_bytes
  GROUP BY
    client,
    page
)
GROUP BY
  client,
  unminified_js_kbytes
ORDER BY
  client,
  unminified_js_kbytes
