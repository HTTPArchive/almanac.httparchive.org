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
    year,
    page,
    domain,
    total
  FROM (
    SELECT
      year,
      page,
      third_party_domains.domain AS domain
    FROM (
      SELECT
        '2022' AS year,
        NET.HOST(data.url) AS domain,
        lighthouse.url AS page
      FROM
        `httparchive.lighthouse.2022_06_01_mobile` AS lighthouse,
        UNNEST(getUrls(JSON_EXTRACT(report, "$.audits['legacy-javascript']"))) AS data
    ) AS potential_third_parties
    INNER JOIN
      third_party_domains
    ON
      potential_third_parties.domain = third_party_domains.domain
    GROUP BY
      year,
      page,
      domain
  )
  JOIN (
    SELECT
      '2022' AS year,
      COUNT(DISTINCT url) AS total
    FROM
      `httparchive.lighthouse.2022_06_01_mobile`
    GROUP BY
      year
  )
  USING (year)
  UNION ALL
  SELECT
    year,
    page,
    domain,
    total
  FROM (
    SELECT
      year,
      page,
      third_party_domains.domain AS domain
    FROM (
      SELECT
        '2021' AS year,
        NET.HOST(data.url) AS domain,
        lighthouse.url AS page
      FROM
        `httparchive.lighthouse.2021_07_01_mobile` AS lighthouse,
        UNNEST(getUrls(JSON_EXTRACT(report, "$.audits['legacy-javascript']"))) AS data
    ) AS potential_third_parties
    INNER JOIN
      third_party_domains
    ON
      potential_third_parties.domain = third_party_domains.domain
    GROUP BY
      year,
      page,
      domain
  )
  JOIN (
    SELECT
      '2021' AS year,
      COUNT(DISTINCT url) AS total
    FROM
      `httparchive.lighthouse.2021_07_01_mobile`
    GROUP BY
      year
  )
  USING (year)
  UNION ALL
  SELECT
    year,
    page,
    domain,
    total
  FROM (
    SELECT
      year,
      page,
      third_party_domains.domain AS domain
    FROM (
      SELECT
        '2020' AS year,
        NET.HOST(data.url) AS domain,
        lighthouse.url AS page
      FROM
        `httparchive.lighthouse.2020_08_01_mobile` AS lighthouse,
        UNNEST(getUrls(JSON_EXTRACT(report, "$.audits['legacy-javascript']"))) AS data
    ) AS potential_third_parties
    INNER JOIN
      third_party_domains
    ON
      potential_third_parties.domain = third_party_domains.domain
    GROUP BY
      year,
      page,
      domain
  )
  JOIN (
    SELECT
      '2020' AS year,
      COUNT(DISTINCT url) AS total
    FROM
      `httparchive.lighthouse.2020_08_01_mobile`
    GROUP BY
      year
  )
  USING (year)
)

SELECT
  year,
  domain,
  freq,
  total,
  pct
FROM (
  SELECT
    year,
    domain,
    COUNT(0) AS freq,
    total,
    COUNT(0) / total AS pct,
    RANK() OVER (PARTITION BY year ORDER BY COUNT(0) DESC) AS domain_rank
  FROM
    base
  GROUP BY
    year,
    domain,
    total
)
WHERE
  domain_rank <= 100
ORDER BY
  year,
  freq DESC
