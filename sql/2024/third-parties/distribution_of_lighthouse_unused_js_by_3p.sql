#standardSQL
# Pages with unused third-party JavaScript

CREATE TEMPORARY FUNCTION getUnusedJavascriptUrls(audit STRING)
RETURNS ARRAY<STRUCT<url STRING, wastedBytes INT64>> LANGUAGE js AS '''
try {
  var $ = JSON.parse(audit);
  return $.details.items.map(({url, wastedBytes}) => {
    return {url, wastedBytes};
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
    SUM(IF(third_party_domains.domain IS NOT NULL, potential_savings, 0)) AS potential_third_party_savings,
    SUM(potential_savings) AS potential_total_savings
  FROM (
    SELECT
      _TABLE_SUFFIX AS client,
      lighthouse.url AS page,
      NET.HOST(data.url) AS domain,
      data.wastedBytes AS potential_savings
    FROM
      `httparchive.lighthouse.2024_06_01_*` AS lighthouse,
      UNNEST(getUnusedJavascriptUrls(JSON_EXTRACT(report, "$.audits['unused-javascript']"))) AS data
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
  percentile,
  APPROX_QUANTILES(potential_third_party_savings, 1000)[OFFSET(percentile * 10)] AS potential_third_party_savings_bytes,
  APPROX_QUANTILES(potential_total_savings, 1000)[OFFSET(percentile * 10)] AS potential_total_savings_bytes
FROM
  base,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  client,
  percentile
ORDER BY
  client,
  percentile
