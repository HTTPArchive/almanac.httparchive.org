WITH RECURSIVE pages AS (
  SELECT
    NET.REG_DOMAIN(page) AS page,
    custom_metrics
  FROM `httparchive.all.pages`
  WHERE date = '2024-06-01'
    AND client = 'desktop'
    AND is_root_page = TRUE
    AND rank <= 10000
), ads AS (
  SELECT
    page,
    JSON_QUERY(custom_metrics, '$.ads.ads.account_types') AS ad_accounts
  FROM pages
  WHERE
    CAST(JSON_VALUE(custom_metrics, '$.ads.ads.account_count') AS INT64) > 0
), sellers AS (
  SELECT
    page,
    JSON_QUERY(custom_metrics, '$.ads.sellers.seller_types') AS ad_sellers
  FROM pages
  WHERE
    CAST(JSON_VALUE(custom_metrics, '$.ads.sellers.seller_count') AS INT64) > 0
), relationships AS (
  SELECT
    NET.REG_DOMAIN(REGEXP_EXTRACT(NORMALIZE_AND_CASEFOLD(domain), r'\b[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\b')) as demand,
    'Web' AS supply,
    'direct' AS relationship,
    page AS publisher
  FROM ads, UNNEST(JSON_VALUE_ARRAY(ad_accounts, '$.direct.domains')) AS domain
  UNION ALL
  SELECT
    NET.REG_DOMAIN(REGEXP_EXTRACT(NORMALIZE_AND_CASEFOLD(domain), r'\b[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\b')) AS demand,
    'Web' AS supply,
    'indirect' AS relationship,
    page AS publisher
  FROM ads, UNNEST(JSON_VALUE_ARRAY(ad_accounts, '$.reseller.domains')) AS domain
  UNION ALL
  SELECT
    page AS demand,
    'Web' AS supply,
    'direct' AS relationship,
    NET.REG_DOMAIN(REGEXP_EXTRACT(NORMALIZE_AND_CASEFOLD(domain), r'\b[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\b')) AS publisher
  FROM sellers, UNNEST(JSON_VALUE_ARRAY(ad_sellers, '$.publisher.domains')) AS domain
  UNION ALL
  SELECT
    page AS demand,
    NET.REG_DOMAIN(REGEXP_EXTRACT(NORMALIZE_AND_CASEFOLD(domain), r'\b[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\b')) AS supply,
    'indirect' AS relationship,
    NULL AS publisher
  FROM sellers, UNNEST(JSON_VALUE_ARRAY(ad_sellers, '$.intermediary.domains')) AS domain
  UNION ALL
  SELECT
    page AS demand,
    'Web' AS supply,
    'direct' AS relationship,
    NET.REG_DOMAIN(REGEXP_EXTRACT(NORMALIZE_AND_CASEFOLD(domain), r'\b[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\b')) AS publisher
  FROM sellers, UNNEST(JSON_VALUE_ARRAY(ad_sellers, '$.both.domains')) AS domain
  UNION ALL
  SELECT
    page AS demand,
    NET.REG_DOMAIN(REGEXP_EXTRACT(NORMALIZE_AND_CASEFOLD(domain), r'\b[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\b')) AS supply,
    'indirect' AS relationship,
    NULL AS publisher
  FROM sellers, UNNEST(JSON_VALUE_ARRAY(ad_sellers, '$.both.domains')) AS domain
), nodes AS (
  (
    SELECT
      demand,
      supply,
      CONCAT(demand, '-', supply) AS path_history,
      relationship,
      HLL_COUNT.INIT(publisher) AS supply_sketch
    FROM relationships
    WHERE supply = 'Web'
    GROUP BY demand, supply, relationship
  )
  UNION ALL
  (
    SELECT
      relationships.demand AS demand,
      relationships.supply AS supply,
      CONCAT(relationships.demand, '-', nodes.path_history) AS path_history,
      relationships.relationship AS relationship,
      nodes.supply_sketch AS supply_sketch
    FROM relationships
    INNER JOIN nodes
    ON relationships.supply = nodes.demand
      AND nodes.supply_sketch IS NOT NULL
      AND nodes.relationship = 'indirect'
      AND STRPOS(nodes.path_history, CONCAT(relationships.demand, '-', relationships.supply)) = 0
  )
)

SELECT
  demand,
  supply,
  path_history,
  relationship,
  HLL_COUNT.MERGE(supply_sketch) AS publishers_count
FROM nodes
GROUP BY demand, supply, relationship, path_history
ORDER BY publishers_count DESC
