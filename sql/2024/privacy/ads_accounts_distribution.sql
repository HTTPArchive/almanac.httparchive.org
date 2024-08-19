WITH publishers AS (
  SELECT
    page,
    JSON_QUERY(custom_metrics, '$.ads.ads.account_types') AS ads_account_types,
    JSON_QUERY(custom_metrics, '$.ads.app_ads.account_types') AS app_ads_account_types
  FROM `httparchive.all.pages`
  WHERE date = '2024-06-01' AND
    is_root_page = TRUE AND
    (CAST(JSON_VALUE(custom_metrics, '$.ads.ads.account_count') AS INT64) > 0 OR
      CAST(JSON_VALUE(custom_metrics, '$.ads.app_ads.account_count') AS INT64) > 0)
), ads_accounts AS (
  SELECT
    page,
    CEIL(CAST(JSON_VALUE(ads_account_types, '$.direct.account_count') AS INT64) / 100) * 100 AS direct_account_count_bucket,
    CEIL(CAST(JSON_VALUE(ads_account_types, '$.reseller.account_count') AS INT64) / 100) * 100 AS reseller_account_count_bucket,
    COUNT(DISTINCT page) OVER () AS total_pages
  FROM publishers
), app_ads_accounts AS (
  SELECT
    page,
    CEIL(CAST(JSON_VALUE(app_ads_account_types, '$.direct.account_count') AS INT64) / 100) * 100 AS direct_account_count_bucket,
    CEIL(CAST(JSON_VALUE(app_ads_account_types, '$.reseller.account_count') AS INT64) / 100) * 100 AS reseller_account_count_bucket,
    COUNT(DISTINCT page) OVER () AS total_pages
  FROM publishers
)

SELECT
  'ads' AS source,
  'direct' AS account_type,
  direct_account_count_bucket AS account_count_bucket,
  COUNT(DISTINCT page) / ANY_VALUE(total_pages) AS pct_pages,
  COUNT(DISTINCT page) AS number_of_pages
FROM ads_accounts
GROUP BY source, direct_account_count_bucket
UNION ALL
SELECT
  'ads' AS source,
  'reseller' AS account_type,
  reseller_account_count_bucket AS account_count_bucket,
  COUNT(DISTINCT page) / ANY_VALUE(total_pages) AS pct_pages,
  COUNT(DISTINCT page) AS number_of_pages
FROM ads_accounts
GROUP BY source, reseller_account_count_bucket
UNION ALL
SELECT
  'app_ads' AS source,
  'direct' AS account_type,
  direct_account_count_bucket AS account_count_bucket,
  COUNT(DISTINCT page) / ANY_VALUE(total_pages) AS pct_pages,
  COUNT(DISTINCT page) AS number_of_pages
FROM app_ads_accounts
GROUP BY source, direct_account_count_bucket
UNION ALL
SELECT
  'app_ads' AS source,
  'reseller' AS account_type,
  reseller_account_count_bucket AS account_count_bucket,
  COUNT(DISTINCT page) / ANY_VALUE(total_pages) AS pct_pages,
  COUNT(DISTINCT page) AS number_of_pages
FROM app_ads_accounts
GROUP BY source, reseller_account_count_bucket

ORDER BY account_count_bucket ASC
LIMIT 1000
