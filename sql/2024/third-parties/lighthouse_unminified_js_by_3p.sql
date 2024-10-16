#standardSQL
# Third-party pages with unminified JavaScript

CREATE TEMPORARY FUNCTION getUnminifiedJavascriptUrls(audit STRING)
RETURNS ARRAY<STRUCT<url STRING, wastedBytes INT64, totalBytes INT64>> LANGUAGE js AS '''
try {
  var $ = JSON.parse(audit);
  return $.details.items.map(({url, wastedBytes, totalBytes}) => {
    return {url, wastedBytes, totalBytes};
  });
} catch (e) {
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
    potential_third_parties.domain AS domain,
    SUM(IF(third_party_domains.domain IS NOT NULL, potential_savings, 0)) AS potential_third_party_savings,
    SUM(IF(third_party_domains.domain IS NOT NULL, transfer_size, 0)) AS third_party_transfer_size
  FROM (
    SELECT
      _TABLE_SUFFIX AS client,
      NET.HOST(data.url) AS domain,
      lighthouse.url AS page,
      data.wastedBytes AS potential_savings,
      data.totalBytes AS transfer_size
    FROM
      `httparchive.lighthouse.2024_06_01_*` AS lighthouse,
      UNNEST(getUnminifiedJavascriptUrls(JSON_EXTRACT(report, "$.audits['unminified-javascript']"))) AS data
  ) AS potential_third_parties
  LEFT OUTER JOIN
    third_party_domains
  ON
    potential_third_parties.domain = third_party_domains.domain
  GROUP BY
    client,
    page,
    domain
)

SELECT
  client,
  domain,
  COUNT(DISTINCT page) AS total_pages,
  SUM(third_party_transfer_size) AS third_party_transfer_size_bytes,
  SUM(potential_third_party_savings) AS potential_third_party_savings_bytes,
  SUM(potential_third_party_savings) / SUM(third_party_transfer_size) AS pct_potential_third_party_savings,
  SUM(potential_third_party_savings) / COUNT(DISTINCT page) AS potential_third_party_savings_bytes_per_page
FROM
  base
WHERE
  potential_third_party_savings > 0
GROUP BY
  client,
  domain
ORDER BY
  client,
  total_pages DESC,
  potential_third_party_savings_bytes_per_page DESC,
  domain
