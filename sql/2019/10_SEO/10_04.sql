#standardSQL

# todo: similar to 10.02
# note: updated the table, but this has no items detailst to parse


CREATE TEMPORARY FUNCTION getViolations(items STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS """
  try {
    return items.match(/hreflang="([^"]*)"/ig);
  } catch (e) {
    return [];
  }
""";

SELECT
  COUNT(0) AS volume,
  lang
FROM (
  SELECT
    getViolations(JSON_EXTRACT(report, "$.audits.hreflang.details.items")) AS langs
  FROM
    `httparchive.lighthouse.2019_07_01_mobile`)
CROSS JOIN
  UNNEST(langs) AS lang
GROUP BY
  lang
ORDER BY
  volume DESC
