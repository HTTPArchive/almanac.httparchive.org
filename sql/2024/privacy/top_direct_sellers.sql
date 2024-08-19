WITH RECURSIVE pages AS (
  SELECT
    CASE page -- publisher websites may redirect to an SSP domain, and need to use redirected domain instead of page domain
      WHEN 'https://www.chunkbase.com/' THEN 'cafemedia.com'
      ELSE NET.REG_DOMAIN(page)
    END AS page,
    JSON_QUERY(custom_metrics, '$.ads') AS ads_metrics
  FROM `httparchive.all.pages`
  WHERE date = '2024-06-01' AND
    client = 'mobile' AND
    is_root_page = TRUE
), ads AS (
  SELECT
    page,
    JSON_QUERY(ads_metrics, '$.ads.account_types') AS ad_accounts
  FROM pages
  WHERE
    JSON_VALUE(ads_metrics, '$.ads.account_count') != '0'
), sellers AS (
  SELECT
    page,
    JSON_QUERY(ads_metrics, '$.sellers.seller_types') AS ad_sellers
  FROM pages
  WHERE
    JSON_VALUE(ads_metrics, '$.sellers.seller_count') != '0'
), relationships AS (
  SELECT
    demand,
    publisher,
    COUNT(DISTINCT publisher) OVER () AS total_publishers
  FROM (
    SELECT
      NET.REG_DOMAIN(domain) AS demand,
      page AS publisher
    FROM ads,
      UNNEST(JSON_VALUE_ARRAY(ad_accounts, '$.direct.domains')) AS domain
    UNION ALL
    SELECT
      page AS demand,
      NET.REG_DOMAIN(domain) AS publisher
    FROM sellers,
      UNNEST(JSON_VALUE_ARRAY(ad_sellers, '$.publisher.domains')) AS domain
    UNION ALL
    SELECT
      page AS demand,
      NET.REG_DOMAIN(domain) AS publisher
    FROM sellers,
      UNNEST(JSON_VALUE_ARRAY(ad_sellers, '$.both.domains')) AS domain
  )
  GROUP BY
    demand,
    publisher
)

SELECT
  demand,
  COUNT(DISTINCT publisher) / ANY_VALUE(total_publishers) AS pct_publishers,
  COUNT(DISTINCT publisher) AS number_of_publishers
FROM relationships
GROUP BY
  demand
ORDER BY pct_publishers DESC
LIMIT 100
