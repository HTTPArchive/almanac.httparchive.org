#standardSQL
# Top 25 Attribution Reporting API Destinations (i.e., advertisers) registered by the most number of distinct third-parties (at site level)

-- Extracting third-parties observed using ARA API on a publisher
CREATE TEMP FUNCTION jsonObjectKeys(input STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS """
  if (!input) {
    return [];
  }
  return Object.keys(JSON.parse(input));
""";

-- Extracting ARA API source registration details being passed by a given third-party (passed as "key")
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
      WHEN ara LIKE 'destination=%' THEN NET.REG_DOMAIN(REPLACE(ara, 'destination=', ''))
      ELSE NULL
    END AS destination,
    COUNT(NET.REG_DOMAIN(page)) AS total_publishers,
    COUNT(DISTINCT NET.REG_DOMAIN(page)) AS distinct_publishers,
    COUNT(third_party_domain) AS total_third_party_domains,
    COUNT(DISTINCT third_party_domain) AS distinct_third_party_domains
  FROM `httparchive.crawl.pages`,
    UNNEST(jsonObjectKeys(JSON_QUERY(custom_metrics, '$.privacy-sandbox.privacySandBoxAPIUsage'))) AS third_party_domain,
    UNNEST(jsonObjectValues(JSON_QUERY(custom_metrics, '$.privacy-sandbox.privacySandBoxAPIUsage'), third_party_domain)) AS ara
  WHERE
    date = '2025-07-01' AND
    is_root_page = TRUE AND
    ara LIKE 'destination%'
  GROUP BY client, destination
  HAVING destination IS NOT NULL
),

ranked_features AS (
  SELECT
    client,
    destination,
    total_publishers,
    distinct_publishers,
    total_third_party_domains,
    distinct_third_party_domains,
    ROW_NUMBER() OVER (
      PARTITION BY client
      ORDER BY distinct_third_party_domains DESC
    ) AS third_party_domain_rank
  FROM ara_features
)

SELECT * FROM ranked_features
WHERE third_party_domain_rank <= 25
ORDER BY client, distinct_third_party_domains DESC;
