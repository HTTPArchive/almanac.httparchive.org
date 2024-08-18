WITH RECURSIVE publishers AS (
  SELECT
    page,
    JSON_QUERY(custom_metrics, '$.ads.ads.account_types') AS account_types
  FROM `httparchive.all.pages`
  WHERE date = '2024-06-01' AND
    is_root_page = TRUE AND
    CAST(JSON_VALUE(custom_metrics, '$.ads.ads.account_count') AS INT64) > 0
), accounts AS (
  SELECT
    page,
    CEIL(CAST(JSON_VALUE(account_types, '$.direct.account_count') AS INT64) / 100) * 100 AS direct_account_count_bucket,
    CEIL(CAST(JSON_VALUE(account_types, '$.reseller.account_count') AS INT64) / 100) * 100 AS reseller_account_count_bucket,
    COUNT(DISTINCT page) OVER () AS total_pages
  FROM publishers
)

SELECT
  'direct' AS account_type,
  direct_account_count_bucket AS account_count_bucket,
  COUNT(DISTINCT page) / ANY_VALUE(total_pages) AS pct_pages,
  COUNT(DISTINCT page) AS number_of_pages
FROM accounts
GROUP BY direct_account_count_bucket
UNION ALL
SELECT
  'reseller' AS account_type,
  reseller_account_count_bucket AS account_count_bucket,
  COUNT(DISTINCT page) / ANY_VALUE(total_pages) AS pct_pages,
  COUNT(DISTINCT page) AS number_of_pages
FROM accounts
GROUP BY reseller_account_count_bucket
ORDER BY account_count_bucket ASC
LIMIT 500
