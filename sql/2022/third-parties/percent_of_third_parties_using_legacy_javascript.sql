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
    page,
    domain
  FROM
    (
      SELECT
        NET.HOST(data.url) AS domain,
        lighthouse.url AS page,
        NET.HOST(data.url) IS NOT NULL AND
        NET.HOST(data.url) IN (
          SELECT domain
          FROM `httparchive.almanac.third_parties`
          WHERE date = '2022-06-01' AND category != 'hosting'
        ) AS is_3p
      FROM
        `httparchive.lighthouse.2022_06_01_mobile` AS lighthouse,
        UNNEST(getUrls(JSON_EXTRACT(report, "$.audits['legacy-javascript']"))) AS data
    )
  WHERE
    is_3p = TRUE
  GROUP BY
    page,
    domain
)

SELECT
  domain,
  COUNT(0) AS freq,
  total,
  COUNT(0) / total AS pct
FROM
  base,
  (
    SELECT
      COUNT(DISTINCT url) AS total
    FROM
      `httparchive.lighthouse.2022_06_01_mobile`
  )
GROUP BY
  domain,
  total
ORDER BY
  freq DESC
