#standardSQL
# Third-parties that use legacy JavaScript

CREATE TEMPORARY FUNCTION
getUrls(audit STRING)
RETURNS ARRAY<STRUCT<url STRING>> LANGUAGE js AS '''
try {
  var $ = JSON.parse(audit);
  return $.details.items.map(i => ({url: i.url}));
} catch(e) {
  return [];
}
''';

WITH base AS (
  SELECT
    page
  FROM
    (
      SELECT
        lighthouse.url AS page
      FROM
        `httparchive.lighthouse.2022_06_01_mobile` AS lighthouse,
        UNNEST(getUrls(JSON_EXTRACT(report, "$.audits['legacy-javascript']"))) AS data
    )
  GROUP BY
    page
)

SELECT
  COUNT(0) AS freq,
  total,
  COUNT(0) / total AS pct
FROM
  base,
  (
    SELECT
      COUNT(DISTINCT url) AS total
    FROM
      `httparchive.lighthouse.2022_06_01_*`
  )
GROUP BY
  total
ORDER BY
  freq DESC
