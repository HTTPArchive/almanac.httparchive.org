-- ara-trigger-registrations-for-different-destinations-by-destinations.sql
-- Analysis of Attribution Reporting API (ARA) Triggers registered for different destinations by destination domains (i.e., advertiser domains):
-- 1. No. of third-parties that register trigger for the given destination
-- 2. Min. epsilon
-- 3. Avg. epsilon
-- 4. Max. epsilon
-- [Higher the epsilon, the more the privacy protection] [Epsilon is always undefined, so last 3 columns are removed for this year atleast]
-- Output comprises 9.5K rows and 1 column.

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
    NET.REG_DOMAIN(page) AS publisher,
    third_party_domain,
    CASE 
      WHEN ara LIKE 'destination=%' THEN NET.REG_DOMAIN(REPLACE(ara, 'destination=', ''))
      ELSE NULL
    END AS destination,
    CASE 
      WHEN ara LIKE 'epsilon=%' THEN SAFE_CAST(REPLACE(ara, 'epsilon=', '') AS FLOAT64)
      ELSE NULL
    END AS epsilon
  FROM `httparchive.all.pages`,
  UNNEST(jsonObjectKeys(JSON_QUERY(custom_metrics, '$.privacy-sandbox.privacySandBoxAPIUsage'))) AS third_party_domain,
  UNNEST(jsonObjectValues(JSON_QUERY(custom_metrics, '$.privacy-sandbox.privacySandBoxAPIUsage'), third_party_domain)) AS ara
  WHERE
    date = '2024-06-01' AND
    client = 'desktop' AND
    is_root_page = TRUE AND
    rank <= 1000000
)
SELECT
  destination,
  COUNT(DISTINCT third_party_domain) AS third_party_count
  -- MIN(CASE WHEN epsilon IS NOT NULL THEN epsilon END) AS min_epsilon,
  -- AVG(CASE WHEN epsilon IS NOT NULL THEN epsilon END) AS avg_epsilon,
  -- MAX(CASE WHEN epsilon IS NOT NULL THEN epsilon END) AS max_epsilon
FROM ara_features
WHERE destination is NOT NULL
GROUP BY destination
HAVING third_party_count > 0
ORDER BY third_party_count DESC;