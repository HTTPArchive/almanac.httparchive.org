#standardSQL
# Sites using the role attribute

SELECT
  client,
  is_root_page,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_sites,
  SUM(COUNTIF(total_role_attributes > 0)) OVER (PARTITION BY client) AS total_using_role,
  SUM(COUNTIF(total_role_attributes > 0)) OVER (PARTITION BY client) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct_using_role,
  percentile,
  APPROX_QUANTILES(total_role_attributes, 1000)[OFFSET(percentile * 10)] AS total_role_usages
FROM (
  SELECT
    client,
    is_root_page,
    CAST(JSON_VALUE(custom_metrics.other.almanac.nodes_using_role.total) AS INT64) AS total_role_attributes
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'
),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client,
  is_root_page
ORDER BY
  percentile,
  client,
  is_root_page;
