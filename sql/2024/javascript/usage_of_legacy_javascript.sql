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
    client,
    page
  FROM
    (
      SELECT
        _TABLE_SUFFIX AS client,
        lighthouse.url AS page
      FROM
        `httparchive.lighthouse.2024_06_01_*` AS lighthouse,
        UNNEST(getUrls(JSON_EXTRACT(report, "$.audits['legacy-javascript']"))) AS data
    )
  GROUP BY
    client,
    page
)

SELECT
  base.client AS client,
  COUNT(0) AS freq,
  total,
  COUNT(0) / total AS pct
FROM
  base
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(DISTINCT url) AS total
  FROM
    `httparchive.lighthouse.2024_06_01_*`
  GROUP BY
    client
)
USING (client)
GROUP BY
  client,
  total
ORDER BY
  client,
  freq DESC
