#standardSQL
# Adoption of different Privacy Sandbox (PS) features by different third-parties and by different publishers

-- Extracting third-parties observed using PS APIs on a publisher
CREATE TEMP FUNCTION jsonObjectKeys(input STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS """
  if (!input) {
    return [];
  }
  return Object.keys(JSON.parse(input));
""";

-- Extracting PS APIs being called by a given third-party (passed as "key")
CREATE TEMP FUNCTION jsonObjectValues(input STRING, key STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS """
  if (!input) {
    return [];
  }
  const jsonObject = JSON.parse(input);
  const values = jsonObject[key] || [];

  function splitByDelimiters(value) {
    const delimiterRegex = new RegExp(',|, |\\n|\\u0000', 'g');
    return value.split(delimiterRegex).map(v => v.trim()).filter(v => v);
  }

  const result = [];
  const replacements = {
    'Ch': 'CH', 'Ua': 'UA', 'Wow64': 'WoW64', 'Dpr': 'DPR', 'Rtt': 'RTT', 'Ect': 'ECT', 'Etc': 'ETC', '-Architecture': '-Arch', '-Arc': '-Arch', '-Archh': '-Arch',
    '-Factors': '-Factor', '-ETC': '-ECT', '-Modal': '-Model', '-UA-UA': '-UA', '-UAm': '-UA', 'UAmodel': 'UA-Model', 'UAplatform': 'UA-Platform', 'Secch-UA': 'Sec-CH-UA',
    'CH-Width': 'CH-Viewport-Width', '-UAodel': '-UA-Model', '-Platformua-Platform': '-Platform', '-Platformuser-Agent': '-Platform', '-Version"': '-Version'
  };
  values.forEach(value => {
    if (value.startsWith('accept-ch|')) {
      const parts = splitByDelimiters(value.replace('accept-ch|', ''));
      parts.forEach(part => {
        if (["UA", "Arch", "Bitness", "Full-Version-List", "Mobile", "Model", "Platform", "Platform-Version", "WoW64"].includes(part)) {
          result.push("Sec-CH-UA-" + part);
        } else {
          let formattedPart = part.split('-').map(segment =>
            segment.charAt(0).toUpperCase() + segment.slice(1).toLowerCase()
          ).join('-');
          for (const [key, value] of Object.entries(replacements)) {
            formattedPart = formattedPart.replace(new RegExp(key, 'g'), value);
          }
          result.push(formattedPart);
        }
      });
    } else {
      result.push(value);
    }
  });

  return result;
""";

WITH privacy_sandbox_features AS (
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
    third_party_domain,
    CASE
      WHEN api LIKE '%opics%|%'
        THEN
          REPLACE(SUBSTR(api, 0, STRPOS(api, '|') - 1) || '-' || SPLIT(api, '|')[SAFE_OFFSET(1)], '|', '-')
      WHEN api LIKE 'attribution-reporting-register-source%'
        THEN
          SPLIT(api, '|')[OFFSET(0)]
      ELSE
        api
    END AS feature
  FROM `httparchive.crawl.pages`,
    UNNEST(jsonObjectKeys(JSON_QUERY(custom_metrics, '$.privacy-sandbox.privacySandBoxAPIUsage'))) AS third_party_domain,
    UNNEST(jsonObjectValues(JSON_QUERY(custom_metrics, '$.privacy-sandbox.privacySandBoxAPIUsage'), third_party_domain)) AS api
  WHERE
    date = '2025-07-01' AND
    is_root_page = TRUE
),

grouped_features AS (
  SELECT
    rank_group,
    feature,
    COUNT(DISTINCT publisher) AS publisher_count,
    COUNT(DISTINCT third_party_domain) AS third_party_count
  FROM privacy_sandbox_features
  GROUP BY rank_group, feature
),

aggregated_features AS (
  SELECT
    feature,
    SUM(CASE WHEN rank_group = '1000' THEN publisher_count ELSE 0 END) AS total_publisher_leq_1000,
    SUM(CASE WHEN rank_group = '1000' THEN publisher_count ELSE 0 END) AS distinct_publisher_leq_1000,
    SUM(CASE WHEN rank_group = '1000' THEN third_party_count ELSE 0 END) AS total_third_parties_leq_1000,
    SUM(CASE WHEN rank_group = '1000' THEN third_party_count ELSE 0 END) AS distinct_third_parties_leq_1000,
    SUM(CASE WHEN rank_group = '10000' THEN publisher_count ELSE 0 END) AS total_publisher_leq_10000,
    SUM(CASE WHEN rank_group = '10000' THEN publisher_count ELSE 0 END) AS distinct_publisher_leq_10000,
    SUM(CASE WHEN rank_group = '10000' THEN third_party_count ELSE 0 END) AS total_third_parties_leq_10000,
    SUM(CASE WHEN rank_group = '10000' THEN third_party_count ELSE 0 END) AS distinct_third_parties_leq_10000,
    SUM(CASE WHEN rank_group = '100000' THEN publisher_count ELSE 0 END) AS total_publisher_leq_100000,
    SUM(CASE WHEN rank_group = '100000' THEN publisher_count ELSE 0 END) AS distinct_publisher_leq_100000,
    SUM(CASE WHEN rank_group = '100000' THEN third_party_count ELSE 0 END) AS total_third_parties_leq_100000,
    SUM(CASE WHEN rank_group = '100000' THEN third_party_count ELSE 0 END) AS distinct_third_parties_leq_100000,
    SUM(CASE WHEN rank_group = '1000000' THEN publisher_count ELSE 0 END) AS total_publisher_leq_1000000,
    SUM(CASE WHEN rank_group = '1000000' THEN publisher_count ELSE 0 END) AS distinct_publisher_leq_1000000,
    SUM(CASE WHEN rank_group = '1000000' THEN third_party_count ELSE 0 END) AS total_third_parties_leq_1000000,
    SUM(CASE WHEN rank_group = '1000000' THEN third_party_count ELSE 0 END) AS distinct_third_parties_leq_1000000,
    SUM(CASE WHEN rank_group = '10000000' THEN publisher_count ELSE 0 END) AS total_publisher_leq_10000000,
    SUM(CASE WHEN rank_group = '10000000' THEN publisher_count ELSE 0 END) AS distinct_publisher_leq_10000000,
    SUM(CASE WHEN rank_group = '10000000' THEN third_party_count ELSE 0 END) AS total_third_parties_leq_10000000,
    SUM(CASE WHEN rank_group = '10000000' THEN third_party_count ELSE 0 END) AS distinct_third_parties_leq_10000000
  FROM grouped_features
  GROUP BY feature
)

SELECT
  feature AS privacy_sandbox_features,
  total_publisher_leq_1000,
  distinct_publisher_leq_1000,
  total_third_parties_leq_1000,
  distinct_third_parties_leq_1000,
  total_publisher_leq_10000,
  distinct_publisher_leq_10000,
  total_third_parties_leq_10000,
  distinct_third_parties_leq_10000,
  total_publisher_leq_100000,
  distinct_publisher_leq_100000,
  total_third_parties_leq_100000,
  distinct_third_parties_leq_100000,
  total_publisher_leq_1000000,
  distinct_publisher_leq_1000000,
  total_third_parties_leq_1000000,
  distinct_third_parties_leq_1000000,
  total_publisher_leq_10000000,
  distinct_publisher_leq_10000000,
  total_third_parties_leq_10000000,
  distinct_third_parties_leq_10000000
FROM aggregated_features
ORDER BY feature;
