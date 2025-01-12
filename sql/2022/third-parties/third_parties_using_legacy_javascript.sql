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
    COUNTIF(third_party_domains.domain IS NULL) / COUNT(0) AS pct_1p_legacy,
    COUNTIF(third_party_domains.domain IS NOT NULL) / COUNT(0) AS pct_3p_legacy
  FROM (
    SELECT
      _TABLE_SUFFIX AS client,
      NET.HOST(data.url) AS domain,
      lighthouse.url AS page
    FROM
      `httparchive.lighthouse.2022_06_01_*` AS lighthouse,
      UNNEST(getUrls(JSON_EXTRACT(report, "$.audits['legacy-javascript']"))) AS data
  ) AS potential_third_parties
  LEFT OUTER JOIN
    third_party_domains
  ON
    potential_third_parties.domain = third_party_domains.domain
  GROUP BY
    client,
    page
)


SELECT
  client,
  AVG(pct_1p_legacy) AS avg_pct_1p_legacy,
  AVG(pct_3p_legacy) AS avg_pct_3p_legacy
FROM
  base
GROUP BY
  client
ORDER BY
  client
