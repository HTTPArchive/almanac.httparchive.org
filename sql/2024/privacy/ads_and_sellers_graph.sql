WITH RECURSIVE pages AS (
  SELECT
    CASE page -- Publisher websites may redirect to an SSP domain, and need to use redirected domain instead of page domain. CASE needs to be replaced with a more robust solution from HTTPArchive/custom-metrics#136.
      WHEN 'https://www.chunkbase.com/' THEN 'cafemedia.com'
      ELSE NET.REG_DOMAIN(page)
    END AS page_domain,
    JSON_QUERY(ANY_VALUE(custom_metrics), '$.ads') AS ads_metrics
  FROM `httparchive.all.pages`
  WHERE date = '2024-06-01' AND
    is_root_page = TRUE
  GROUP BY page_domain
), ads AS (
  SELECT
    page_domain,
    JSON_QUERY(ads_metrics, '$.ads.account_types') AS ad_accounts
  FROM pages
  WHERE
    CAST(JSON_VALUE(ads_metrics, '$.ads.account_count') AS INT64) > 0
), sellers AS (
  SELECT
    page_domain,
    JSON_QUERY(ads_metrics, '$.sellers.seller_types') AS ad_sellers
  FROM pages
  WHERE
    CAST(JSON_VALUE(ads_metrics, '$.sellers.seller_count') AS INT64) > 0
), relationships_web AS (
  SELECT
    NET.REG_DOMAIN(REGEXP_EXTRACT(NORMALIZE_AND_CASEFOLD(domain), r'\b[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\b')) AS demand,
    'Web' AS supply,
    'direct' AS relationship,
    page_domain AS publisher
  FROM ads, UNNEST(JSON_VALUE_ARRAY(ad_accounts, '$.direct.domains')) AS domain
  UNION ALL
  SELECT
    NET.REG_DOMAIN(REGEXP_EXTRACT(NORMALIZE_AND_CASEFOLD(domain), r'\b[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\b')) AS demand,
    'Web' AS supply,
    'indirect' AS relationship,
    page_domain AS publisher
  FROM ads, UNNEST(JSON_VALUE_ARRAY(ad_accounts, '$.reseller.domains')) AS domain
  UNION ALL
  SELECT
    page_domain AS demand,
    'Web' AS supply,
    'direct' AS relationship,
    NET.REG_DOMAIN(REGEXP_EXTRACT(NORMALIZE_AND_CASEFOLD(domain), r'\b[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\b')) AS publisher
  FROM sellers, UNNEST(JSON_VALUE_ARRAY(ad_sellers, '$.publisher.domains')) AS domain
  UNION ALL
  SELECT
    page_domain AS demand,
    'Web' AS supply,
    'direct' AS relationship,
    NET.REG_DOMAIN(REGEXP_EXTRACT(NORMALIZE_AND_CASEFOLD(domain), r'\b[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\b')) AS publisher
  FROM sellers, UNNEST(JSON_VALUE_ARRAY(ad_sellers, '$.both.domains')) AS domain
), relationships_adtech AS (
  SELECT
    page_domain AS demand,
    NET.REG_DOMAIN(REGEXP_EXTRACT(NORMALIZE_AND_CASEFOLD(domain), r'\b[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\b')) AS supply,
    'indirect' AS relationship
  FROM sellers, UNNEST(JSON_VALUE_ARRAY(ad_sellers, '$.intermediary.domains')) AS domain
  UNION ALL
  SELECT
    page_domain AS demand,
    NET.REG_DOMAIN(REGEXP_EXTRACT(NORMALIZE_AND_CASEFOLD(domain), r'\b[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\b')) AS supply,
    'indirect' AS relationship
  FROM sellers, UNNEST(JSON_VALUE_ARRAY(ad_sellers, '$.both.domains')) AS domain
), nodes AS (
  (
    SELECT
      demand,
      supply,
      CONCAT(demand, '-', supply) AS path,
      relationship,
      HLL_COUNT.INIT(publisher) AS supply_sketch
    FROM relationships_web
    GROUP BY demand, supply, relationship
  )
  UNION ALL
  (
    SELECT
      relationships_grouped.demand AS demand,
      relationships_grouped.supply AS supply,
      CONCAT(relationships_grouped.demand, '-', nodes.path) AS path,
      relationships_grouped.relationship AS relationship,
      nodes.supply_sketch AS supply_sketch
    FROM (
      SELECT
        demand,
        supply,
        relationship
      FROM relationships_adtech
      GROUP BY
        demand,
        supply,
        relationship
    ) AS relationships_grouped
    INNER JOIN nodes
    ON relationships_grouped.supply = nodes.demand AND
      nodes.supply_sketch IS NOT NULL AND
      nodes.relationship = 'indirect' AND
      relationships_grouped.demand IS NOT NULL AND
      STRPOS(nodes.path, relationships_grouped.demand) = 0
  )
)

SELECT
  supply,
  demand,
  HLL_COUNT.MERGE(supply_sketch) AS publishers_count,
  relationship,
  path
FROM nodes
GROUP BY demand, supply, relationship, path
ORDER BY publishers_count DESC
LIMIT 5000
