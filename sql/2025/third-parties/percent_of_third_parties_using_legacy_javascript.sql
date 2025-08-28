#standardSQL
# Percent third-party scripts that use legacy JavaScript

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

WITH third_party_domains AS (
  SELECT DISTINCT
    NET.HOST(domain) AS domain
  FROM
    `httparchive.almanac.third_parties`
),

base AS (
  SELECT
    client,
    page,
    third_party_domains.domain AS domain
  FROM
    (
      SELECT
        _TABLE_SUFFIX AS client,
        NET.HOST(data.url) AS domain,
        lighthouse.url AS page
      FROM
        `httparchive.lighthouse.2025_06_01_*` AS lighthouse,
        UNNEST(getUrls(JSON_EXTRACT(report, "$.audits['legacy-javascript']"))) AS data
    ) AS potential_third_parties
  INNER JOIN
    third_party_domains
  ON
    potential_third_parties.domain = third_party_domains.domain
  GROUP BY
    client,
    page,
    domain
)

SELECT
  base.client AS client,
  domain,
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
    `httparchive.lighthouse.2025_06_01_*`
  GROUP BY
    _TABLE_SUFFIX
)
USING (client)
GROUP BY
  client,
  domain,
  total
ORDER BY
  client,
  freq DESC
