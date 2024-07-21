WITH RECURSIVE pages AS (
  SELECT
    NET.REG_DOMAIN(page) AS page,
    custom_metrics
  FROM `httparchive.all.pages`
  WHERE date = '2024-06-01' AND
    client = 'desktop' AND
    is_root_page = TRUE AND
    rank <= 10000
), ads AS (
  SELECT
    CEIL(CAST(JSON_VALUE(custom_metrics, '$.ads.ads.account_types.direct.account_count') AS INT64)/100)*100 AS direct_account_count_bucket,
    CEIL(CAST(JSON_VALUE(custom_metrics, '$.ads.ads.account_types.reseller.account_count') AS INT64)/100)*100 AS reseller_account_count_bucket
  FROM pages
  WHERE
    CAST(JSON_VALUE(custom_metrics, '$.ads.ads.account_count') AS INT64) > 0
)

SELECT
  'direct' AS account_type,
  direct_account_count_bucket AS account_count_bucket,
  COUNT(0) AS page_count
FROM ads
GROUP BY direct_account_count_bucket
UNION ALL
SELECT
  'reseller' AS account_type,
  reseller_account_count_bucket AS account_count_bucket,
  COUNT(0) AS page_count
FROM ads
GROUP BY reseller_account_count_bucket
ORDER BY account_count_bucket ASC
LIMIT 200
