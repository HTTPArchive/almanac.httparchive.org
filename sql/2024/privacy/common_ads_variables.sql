WITH RECURSIVE pages AS (
  SELECT
    page,
    JSON_QUERY(custom_metrics, '$.ads.ads') AS ads_metrics
  FROM `httparchive.all.pages`
  WHERE
    date = '2024-06-01' AND
    is_root_page = TRUE AND
    CAST(JSON_VALUE(custom_metrics, '$.ads.ads.account_count') AS INT64) > 0
), ads AS (
  SELECT
    page,
    variable,
    COUNT(DISTINCT page) OVER() AS total_publishers
  FROM pages,
    UNNEST(JSON_VALUE_ARRAY(ads_metrics, '$.variables')) AS variable
  WHERE
    CAST(JSON_VALUE(ads_metrics, '$.account_types.reseller.account_count') AS INT64) > 0 OR
    CAST(JSON_VALUE(ads_metrics, '$.account_types.direct.account_count') AS INT64) > 0
)

SELECT
  variable,
  COUNT(DISTINCT page) / ANY_VALUE(total_publishers) AS pct_publishers,
  COUNT(DISTINCT page) AS number_of_publishers
FROM ads
GROUP BY variable
ORDER BY pct_publishers DESC
LIMIT 100
