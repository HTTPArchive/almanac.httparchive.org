#standardSQL
# Number of Attribution Reporting API Destinations (i.e., advertisers) registered, registering third-parties, and registering publishers (at site level)

-- Extracting third-parties observed using ARA API on a publisher
CREATE TEMP FUNCTION jsonObjectKeys(input STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS """
  if (!input) {
    return [];
  }
  return Object.keys(JSON.parse(input));
""";

-- Extracting ARA API source registration details being passed by a given third-party (passed AS "key")
CREATE TEMP FUNCTION jsonObjectValues(input STRING, key STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS """
  if (!input) {
    return [];
  }
  const jsonObject = JSON.parse(input);
  const values = jsonObject[key] || [];
  const result = [];

  values.forEach(value => {
    if (value.toLowerCase().startsWith('attribution-reporting-register-source|')) {
      const parts = value.replace('attribution-reporting-register-source|', '').split('|');
      parts.forEach(part => {
        if (part.startsWith('destination=')) {
          const destinations = part.replace('destination=', '').split(',');
          destinations.forEach(destination => {
            result.push('destination=' + destination.trim());
          });
        } else {
          result.push(part.trim());
        }
      });
    }
  });

  return result;
""";

WITH ara_features AS (
  SELECT
    client,
    CASE
      WHEN rank <= 1000 THEN '1000'
      WHEN rank <= 10000 THEN '10000'
      WHEN rank <= 100000 THEN '100000'
      WHEN rank <= 1000000 THEN '1000000'
      WHEN rank <= 10000000 THEN '10000000'
      ELSE 'Other'
    END AS rank_group,
    NET.REG_DOMAIN(page) AS publisher,
    CASE
      WHEN ara LIKE 'destination=%' THEN NET.REG_DOMAIN(REPLACE(ara, 'destination=', ''))
      ELSE NULL
    END AS destination,
    third_party_domain
  FROM `httparchive.all.pages`,
    UNNEST(jsonObjectKeys(JSON_QUERY(custom_metrics, '$.privacy-sandbox.privacySandBoxAPIUsage'))) AS third_party_domain,
    UNNEST(jsonObjectValues(JSON_QUERY(custom_metrics, '$.privacy-sandbox.privacySandBoxAPIUsage'), third_party_domain)) AS ara
  WHERE
    date = '2024-06-01' AND
    is_root_page = TRUE AND
    ara LIKE 'destination%'
)

SELECT
  client,
  rank_group,
  COUNT(destination) AS total_destinations,
  COUNT(DISTINCT destination) AS distinct_destinations,
  ROUND(COUNT(DISTINCT destination) * 100 / COUNT(destination), 2) AS destination_pct,
  COUNT(third_party_domain) AS total_third_party_domains,
  COUNT(DISTINCT third_party_domain) AS distinct_third_party_domains,
  ROUND(COUNT(DISTINCT third_party_domain) * 100 / COUNT(third_party_domain), 2) AS third_party_domain_pct,
  COUNT(publisher) AS total_publishers,
  COUNT(DISTINCT publisher) AS distinct_publishers,
  ROUND(COUNT(DISTINCT publisher) * 100 / COUNT(publisher), 2) AS publisher_pct
FROM ara_features
WHERE destination IS NOT NULL AND third_party_domain IS NOT NULL
GROUP BY client, rank_group
ORDER BY
  client,
  CASE rank_group
    WHEN '1000' THEN 1
    WHEN '10000' THEN 2
    WHEN '100000' THEN 3
    WHEN '1000000' THEN 4
    WHEN '10000000' THEN 5
    ELSE 6
  END;
