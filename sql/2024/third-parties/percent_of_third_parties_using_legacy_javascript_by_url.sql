#standardSQL
# Percent third-party scripts that use legacy JavaScript by URLs

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
    third_party_domains.domain AS domain,
    url
  FROM
    (
      SELECT
        _TABLE_SUFFIX AS client,
        data.url AS url,
        NET.HOST(data.url) AS domain,
        lighthouse.url AS page
      FROM
        `httparchive.lighthouse.2024_06_01_*` AS lighthouse,
        UNNEST(getUrls(JSON_EXTRACT(report, "$.audits['legacy-javascript']"))) AS data
    ) AS potential_third_parties
  INNER JOIN
    third_party_domains
  ON
    potential_third_parties.domain = third_party_domains.domain
  GROUP BY
    client,
    page,
    domain,
    url
)

SELECT
  client,
  domain,
  url,
  freq,
  total,
  pct
FROM (
  SELECT
    base.client AS client,
    domain,
    url,
    COUNT(0) AS freq,
    total,
    COUNT(0) / total AS pct,
    RANK() OVER (PARTITION BY base.client ORDER BY COUNT(0) DESC) AS url_rank
  FROM
    base
  JOIN (
      SELECT
        _TABLE_SUFFIX AS client,
        COUNT(DISTINCT url) AS total
      FROM
        `httparchive.lighthouse.2024_06_01_*`
      GROUP BY
        _TABLE_SUFFIX
  )
  USING
    (client)
  GROUP BY
    client,
    domain,
    url,
    total
)
WHERE
  url_rank <= 100
ORDER BY
  client,
  freq DESC
