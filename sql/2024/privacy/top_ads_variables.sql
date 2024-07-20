WITH
  RECURSIVE pages AS (
  SELECT
    NET.REG_DOMAIN(page) AS page,
    custom_metrics
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01'
    AND client = 'desktop'
    AND is_root_page = TRUE
    AND rank <= 10000 ),
  ads AS (
  SELECT
    page,
    variable,
    COUNT(DISTINCT page) OVER() AS total_publishers
  FROM
    pages,
    UNNEST(JSON_VALUE_ARRAY(custom_metrics, '$.ads.ads.variables')) AS variable
  WHERE
    CAST(JSON_VALUE(custom_metrics, '$.ads.ads.account_types.reseller.account_count') AS INT64) > 0 OR
    CAST(JSON_VALUE(custom_metrics, '$.ads.ads.account_types.direct.account_count') AS INT64) > 0 )


SELECT
  variable,
  COUNT(DISTINCT page) AS publishers_count,
  ANY_VALUE(total_publishers) AS total_publishers
FROM
  ads
GROUP BY
  variable
ORDER BY
  publishers_count DESC
