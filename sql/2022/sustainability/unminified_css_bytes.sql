#standardSQL
# Histogram of wasted bytes per page

CREATE TEMPORARY FUNCTION getUnminifiedCssBytes(audit STRING)
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
  IF(unminified_css_kbytes <= 200, CEIL(unminified_css_kbytes / 10) * 10, 200) AS unminified_css_kbytes,
  COUNT(0) AS pages,
  SUM(COUNT(0)) OVER () AS total,
  COUNT(0) / SUM(COUNT(0)) OVER () AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    test.url AS page,
    SUM(IFNULL(unminified_css_bytes, 0)) / 1024 AS unminified_css_kbytes
  FROM
    `httparchive.lighthouse.2021_06_01_*` AS test
  LEFT JOIN
    UNNEST(getUnminifiedCssBytes(JSON_EXTRACT(report, "$.audits['unminified-css']"))) AS unminified_css_bytes
  GROUP BY
    page,
    client
)
GROUP BY
  client,
  unminified_css_kbytes
ORDER BY
  client,
  unminified_css_kbytes
